clc
clear

gt = imread('GroundTruth_0019.tif');
Elad = double( imread('SR_NLM_0019.tif'));
load '29_Aug_2011_15_39_08Z0_7-262-7-182-Patch-6-Missamerica_frame19.mat';

% Foreman
% k_s= 121 ;
% k_e =  279;
% l_s = 54;
% l_e = 203;


% Miss america
% k_s= 7 ;
% k_e =  262;
% l_s = 7;
% l_e = 182;

% Suzie
k_s= 7 ;
k_e =  262;
l_s = 7;
l_e = 182;


PSNR(double(Elad(k_s:k_e,l_s:l_e)),double(gt(k_s:k_e,l_s:l_e)))

PSNR(double(Z0(k_s:k_e,l_s:l_e)),double(gt(k_s:k_e,l_s:l_e)))
PSNR(double(Z0),double(gt))



ssim(double(Elad(k_s:k_e,l_s:l_e)),double(gt(k_s:k_e,l_s:l_e)))
ssim(double(Z0(k_s:k_e,l_s:l_e)),double(gt(k_s:k_e,l_s:l_e)))

