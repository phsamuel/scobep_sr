% lanczos =imread('Im1.tif');
% lanczos = imresize(lanczos,s,'bicubic');
% elad = lanczos;
elad =imread('Text_Im5_NLM_SR.tif');

gg =imread('Im5_GroundTruth.tif');
A = double(gg)/255;

B = double(elad)/255;

if A == B
   error('Images are identical: PSNR has infinite value')
end

max2_A = max(max(A));
max2_B = max(max(B));
min2_A = min(min(A));
min2_B = min(min(B));

if max2_A > 1 || max2_B > 1 || min2_A < 0 || min2_B < 0
   error('input matrices must have values in the interval [0,1]')
end

error_diff = A - B;
decibels = 20*log10(1/(sqrt(mean(mean(error_diff.^2)))));
disp(sprintf('PSNR = +%5.2f dB',decibels))