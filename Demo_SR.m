% function Demo_SR( )
% clear
clc
% close all
%% initialization
s = 3; % upsamling factor
q =1;
p = s * (q-1)+1;
dx = 2;
dy=2;
sigma= 2.2;
q2 = ceil(q/2);
R_hat = 13;

constant = 1;
y = readframes();
Y = myinitial (y,s);

% k_s= 218+14+180 ;
% k_e =  678-50-100;
% l_s = 374+34  +37;
% l_e = 897-85-40;

% Y = Y(k_s: k_e, l_s: l_e,:);
         
         
%    Suzie
 tt = [18;28];
%   Miss        
%tt = [8;13];
% Z0 = Y(:,:,1);
for frame = 1 : 2
Z0 = Y(:,:,tt(frame));
Search_area = 3;
patchsize = 6;
searchPixels = 10*s-1;

% sz = zeros(size(Y,1),size(Y,2));
% for ii =1 : 9
%
%
%     sz =sz + Y(:,:,ii);
%
% end
%
% Z0 = sz/9;

V = zeros(size(Z0));
W = zeros(size(Z0));

%% Fusion
% figure;
subplot(1,3,1); imshow(Z0,[]);
% for iter=1: 2
    tic
    Z0 = findZ(Z0,Y,sigma,y,s,R_hat,Search_area,searchPixels,patchsize);
    toc
    
     
 filename=datestr(now);
    filename(filename==' ')='_';
    filename(filename==':')='_';
    filename(filename=='-')='_';
    save(strcat(filename,'Z0','_7-262-7-182-Patch-6-Missamerica_','frame',int2str(frame),'.mat'),'Z0','-v7.3');
    
    
    
%     subplot(1,3,iter+1); imshow(Z0,[]);
%     %  figure;imshow(Z0,[]);
%     if iter == 1
%         save('Z01_set11')
%     else
%         save('Z02_set11')
%     end
% end

figure;imshow(Z0,[]);
end
%% Denoising
% Load test images.
% Note: Must be double precision in the interval [0,1].


% Introduce AWGN into test images.
% Note: This will show the benefit of bilateral filtering.
img2 = Z0(58:101,88:158)/255;
img2 = img2+0.03*randn(size(img2));

img2(img2<0) = 0; img2(img2>1) = 1;

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [3 0.1]; % bilateral filter standard deviations

% Apply bilateral filter to each image.

bflt_img2 = bfilter2(img2,w,sigma);

figure; imshow(bflt_img2,[]);
%% Deblurring
%  load BeforeDeblurring.mat
k_s=1; k_e=240; l_s=1; l_e=351;
Z10 = Z0(k_s:k_e,l_s:l_e);
J=Z10;
image = Z10;
% params
std_n = 0.3;
ep_J = 0.1; % minimum mean change in image J
lam=0; J_old=0;
iter=12; dt=0.16; eps=1;
var_n = std_n^2; % noise variance

% J_old = J;
% J=tv(J,iter,dt,eps,lam,image);     % scalar lam
% lam = calc_lam(J,image,var_n,eps);


while (mean(mean(abs(J - J_old))) > ep_J),  % iterate until convergence
    J_old = J;
    J=tv(J,iter,dt,eps,lam,image);     % scalar lam
    lam = calc_lam(J,image,var_n,eps); % update lambda (fidelity term)
end % for i
%
% Z0 = J;

% PSNR(J,double(gt(k_s:k_e,l_s:l_e)))


%% Display
figure;imshow(y(:,:,1,1),[]);
figure;imshow(Y(:,:,1),[]);
figure;imshow(Z0(ceil(l/2)+1:end-ceil(l/2)+1,ceil(l/2)+1:end-ceil(l/2)+1),[]);
figure;imshow(J,[]);
% 
% end


% function [Y] = initial (y,s)
% % for i =1 : size(y,4)
%   for i =1 : size(y,3)  
% %     Y(:,:,i) = imresize(y(:,:,:,i),s,'lanczos3'); FORman
%     Y(:,:,i) = imresize(y(:,:,i),s,'lanczos3');
%     %         repmat
%     %         temp = YY(:,:,i);
%     %         temp = [repmat(temp(:,1),[1,k]), temp];
%     %         temp=[temp, repmat(temp(:,size(temp,2)),[1,k])];
%     %
%     %         temp = [repmat(temp(1,:),[l,1]); temp];
%     %         temp=[temp; repmat(temp(size(temp,1),:),[l,1])];
%     %
%     %         Y(:,:,i) = temp;
% end
% end
