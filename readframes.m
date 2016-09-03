function [ im ] = readframes()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im = [];

load 'Suzie_SR.mat';
im = double(y_observation);

% load 'Lung_70-80.mat'

% load 'noisy_Forman_gaus_2.mat'
% im = noisy;

 
% % % % % % % % % % % % % % % % % % % % % % % % % % 
% dirfiles = dir ('./BaysFrames/city/input/*.png');
% k= 1;
% for j = 1 : 34
%     
%     str = strcat('./BaysFrames/city/input/', dirfiles(j).name);
%     Im2 = rgb2gray(imread(str));
% %      Im2 = imread(str);
% %         Im2 = imcrop(Im2,[20 20 70 70]);
% %     im(:,:,:,j) = double(Im2);
%     im(:,:,k) = double(Im2);
%     k = k+1;
% %      figure; imshow (Im2,[]);
% %      pause (0.08)
% end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% figure;
% dirfiles = dir ('./MissAmerica/*.tif');
% for j =1 : length(dirfiles)
%     str = strcat('./MissAmerica/', dirfiles(j).name);
% %    Im2 = rgb2gray(imread(str));
%      Im2 = imread(str);
% %         Im2 = imcrop(Im2,[20 20 70 70]);
% %     im(:,:,:,j) = double(Im2);
%     im(:,:,j) = double(Im2);
% %      subplot(4,6,j); imshow (Im2,[]);
%      pause (0.08)
% end




% load './Stefan/Stefan.mat'
% 
% im = y_input;


% imageName = 'Im';
%
% for i = 1:9
%
%     imgINumber = i;
%
%     if imgINumber < 10
%         imgIFile = sprintf('./Text/%s%d.tif', imageName, imgINumber);
%     elseif imgINumber < 100
%         imgIFile = sprintf('./Text/%s%d.tif',imageName, imgINumber);
%     end
%
%     Im2= double(imread(imgIFile));
%         Im2 = imcrop(Im2,[5 5 60 60]);
%     im(:,:,:,i)= Im2;
% end
end

