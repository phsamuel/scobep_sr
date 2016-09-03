load 'Nanjo.mat';

for frame = 1 : size(im,3)
    imwrite(uint8(im(:,:,frame)),strcat('Navajo',int2str(frame),'.tif'));
end