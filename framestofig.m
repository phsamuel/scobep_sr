clear
load 'miss_Z0_DEB.mat';
load 'miss_nearest.mat';
h=figure(1);
filename = 'Miss_both.gif';
for rotation=1:30
    im1=uint8(miss_nearest(:,:,rotation));
    im2=uint8(miss_Z0(:,:,rotation));
    
    
    im1 = [im1,im2];
    
    I=im1;
    I(:,:,2)=im1;
    I(:,:,3)=im1;
    
    
    [imind,cm] = rgb2ind(I,256);
    if rotation ==1;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end