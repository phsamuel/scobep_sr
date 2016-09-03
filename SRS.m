function loss= SRS(cleanFile, enhancedFile,mtype)



% ----------------------------------------------------------------------
% Spring 2009
% This function implements the SNRloss measure described in  [1]
% Usage: loss  = SNRloss(cleanFile.wav,enhancedFile.wav,noiseFile,mtype); 
%            mtype šC speech material type, 1-consonant weights, 2-sentence weights
%            cleanFile.wav -  clean speech file name
%            enhancedFile.wav -  enhanced speech file name
%            loss - the objective intelligibility score of SNRloss measure
%
%  Example call:  loss=SNRloss('S_03_01.wav','S_03_01_babble_sn0_klt.wav',2);
%
% References:
% [1]Ma, J., Loizou, P.C., SNRloss: A new objective measure for predicting speech intelligibility of noise-suppressed speech,
% Speech Comm. (2010), doi:10.1016/j.specom.2010.10.005
% ----------------------------------------------------------------------

if nargin~=3
    fprintf('USAGE: loss=SNRloss(cleanFile.wav, enhancedFile.wav,mtype)\n');
    fprintf('For more help, type: help SNRloss\n\n');
    return;
end


data1= cleanFile;
data2= enhancedFile;

Srate1= 30;
len= min(min(length( data1)), length( data2));
data1= data1( 1: len)+eps;
data2= data2( 1: len)+eps;

wss_dist_vec_noisy= fwseg_noise(data1', data2',Srate1,mtype);

loss=mean(wss_dist_vec_noisy); %%implment of Eq.(6) in paper



% ----------------------------------------------------------------------

function distortion = fwseg_noise(clean_speech, processed_speech,sample_rate,mtype)


% ----------------------------------------------------------------------
% Check the length of the noisy, the clean and processed speech.  Must be the same.
% ----------------------------------------------------------------------

clean_length      = length(clean_speech);
processed_length  = length(processed_speech);

if ( clean_length ~= processed_length)
  disp('Error: Files  must have same length.');
  return
end



% ----------------------------------------------------------------------
% Global Variables
lowlim=-3;highlim=3;

len=20;
% ----------------------------------------------------------------------


winlength   = round(len*sample_rate/1000); 	   % window length in samples
skiprate    = floor(winlength/4);		   % window skip in samples
% skiprate    = winlength;	
max_freq    = sample_rate/2;	   % maximum bandwidth
num_crit    = 25;		   % number of critical bands
USE_25=1;
n_fft       = 2^nextpow2(2*winlength);
n_fftby2    = n_fft/2;		   % FFT size/2

% ----------------------------------------------------------------------
% Critical Band Filter Definitions (Center Frequency and Bandwidths in Hz)
% ----------------------------------------------------------------------

cent_freq(1)  = 50.0000;   bandwidth(1)  = 70.0000;
cent_freq(2)  = 120.000;   bandwidth(2)  = 70.0000;
cent_freq(3)  = 190.000;   bandwidth(3)  = 70.0000;
cent_freq(4)  = 260.000;   bandwidth(4)  = 70.0000;
cent_freq(5)  = 330.000;   bandwidth(5)  = 70.0000;
cent_freq(6)  = 400.000;   bandwidth(6)  = 70.0000;
cent_freq(7)  = 470.000;   bandwidth(7)  = 70.0000;
cent_freq(8)  = 540.000;   bandwidth(8)  = 77.3724;
cent_freq(9)  = 617.372;   bandwidth(9)  = 86.0056;
cent_freq(10) = 703.378;   bandwidth(10) = 95.3398;
cent_freq(11) = 798.717;   bandwidth(11) = 105.411;
cent_freq(12) = 904.128;   bandwidth(12) = 116.256;
cent_freq(13) = 1020.38;   bandwidth(13) = 127.914;
cent_freq(14) = 1148.30;   bandwidth(14) = 140.423;
cent_freq(15) = 1288.72;   bandwidth(15) = 153.823;
cent_freq(16) = 1442.54;   bandwidth(16) = 168.154;
cent_freq(17) = 1610.70;   bandwidth(17) = 183.457;
cent_freq(18) = 1794.16;   bandwidth(18) = 199.776;
cent_freq(19) = 1993.93;   bandwidth(19) = 217.153;
cent_freq(20) = 2211.08;   bandwidth(20) = 235.631;
cent_freq(21) = 2446.71;   bandwidth(21) = 255.255;
cent_freq(22) = 2701.97;   bandwidth(22) = 276.072;
cent_freq(23) = 2978.04;   bandwidth(23) = 298.126;
cent_freq(24) = 3276.17;   bandwidth(24) = 321.465;
cent_freq(25) = 3597.63;   bandwidth(25) = 346.136;

NewaCaWghts =[

         0
         0
    0.0092
    0.0245
    0.0354
    0.0398
    0.0414
    0.0427
    0.0447
    0.0472
    0.0473
    0.0472
    0.0476
    0.0511
    0.0529
    0.0551
    0.0586
    0.0657
    0.0711
    0.0746
    0.0749
    0.0717
    0.0681
    0.0668
    0.0653];

NewSenWghts =[
    0.0064
    0.0154
    0.0240
    0.0373
    0.0803
    0.0978
    0.0982
    0.0809
    0.0690
    0.0608
    0.0529
    0.0473
    0.0440
    0.0440
    0.0470
    0.0489
    0.0486
    0.0491
    0.0492
    0.0500
    0.0538
    0.0551
    0.0545
    0.0508
    0.0449];

if mtype==1
    W_freq=NewaCaWghts';
else
    W_freq=NewSenWghts';
end;

% ----------------------------------------------------------------------
% Set up the critical band filters.  Note here that Gaussianly shaped
% filters are used.  Also, the sum of the filter weights are equivalent
% for each critical band filter.  Filter less than -30 dB and set to
% zero.
% ----------------------------------------------------------------------

bw_min     = bandwidth (1);	   % minimum critical bandwidth
min_factor = exp (-30.0 / (2.0 * 2.303));       % -30 dB point of filter
if USE_25==0
    
    num_crit=length(cent_freq2);

    for i = 1:num_crit
        f0 = (cent_freq2 (i) / max_freq) * (n_fftby2);
        all_f0(i) = floor(f0);
        bw = (bandwidth2 (i) / max_freq) * (n_fftby2);
        norm_factor = log(bw_min) - log(bandwidth2(i));
        j = 0:1:n_fftby2-1;
        crit_filter(i,:) = exp (-11 *(((j - floor(f0)) ./bw).^2) + norm_factor);
        crit_filter(i,:) = crit_filter(i,:).*(crit_filter(i,:) > min_factor);
    end

else
    for i = 1:num_crit
        f0 = (cent_freq (i) / max_freq) * (n_fftby2);
        all_f0(i) = floor(f0);
        bw = (bandwidth (i) / max_freq) * (n_fftby2);
        norm_factor = log(bw_min) - log(bandwidth(i));
        j = 0:1:n_fftby2-1;
        crit_filter(i,:) = exp (-11 *(((j - floor(f0)) ./bw).^2) + norm_factor);
        crit_filter(i,:) = crit_filter(i,:).*(crit_filter(i,:) > min_factor);
    end
end



num_frames = clean_length/skiprate-(winlength/skiprate); % number of frames
start      = 1;					% starting sample
window     = 0.5*(1 - cos(2*pi*(1:winlength)'/(winlength+1)));

for frame_count = 1:num_frames

   % ----------------------------------------------------------
   % (1) Get the Frames for the test and reference speech. 
   %     Multiply by Hanning Window.
   % ----------------------------------------------------------

   clean_frame       = clean_speech(start:start+winlength-1);
   processed_frame   = processed_speech(start:start+winlength-1);
   clean_frame       = clean_frame.*window;
   processed_frame   = processed_frame.*window;
   
   % ----------------------------------------------------------
   % (2) Compute the magnitude Spectrum energy of Clean and Processed
   % ----------------------------------------------------------
    
       clean_spec     = abs(fft(clean_frame,n_fft)).^2;
       processed_spec = abs(fft(processed_frame,n_fft)).^2; 

   % ----------------------------------------------------------
   % (3) Compute Filterbank Output Energies 
   % ----------------------------------------------------------
   
   clean_energy     = zeros(1,num_crit);
   processed_energy = zeros(1,num_crit);
   

   for i = 1:num_crit
     
      clean_energy(i)     = sum(clean_spec(1:n_fftby2) ...
                         	.*crit_filter(i,:)');
      processed_energy(i) = sum(processed_spec(1:n_fftby2) ...
                            .*crit_filter(i,:)');                                             
   end;

%-------------------------------------------------------------
%   
    
    SNRloss     = 10*log10(clean_energy./processed_energy);  % Eq. 3
    SNRloss_lim = min(max(SNRloss,lowlim),highlim);  %implment of Eq.(4) in paper
          
     cp=1; cn=1;    %c=0.2,0.4,0.6,0.8,1
     for k=1:25; % mapping to [0,1]
        if SNRloss_lim(k)>=0
            AISNRloss(k) =(cp/highlim)*SNRloss_lim(k);% 
        else
            AISNRloss(k) =(cn/lowlim)*SNRloss_lim(k); %implment of Eq.(5) in paper
        end;  
     end; 

%------------------------------------------------------------------
    AI   =  max(0,sum(W_freq.*AISNRloss)/sum(W_freq)); % Eq.7
%-------------------------------------------------------------
   distortion(frame_count)=AI;
   start = start + skiprate;
     
end
