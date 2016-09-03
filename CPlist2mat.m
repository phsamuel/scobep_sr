

for t = 1 : 30
     str = strcat('i', num2str(t),'.mat');
load (str);

y_image_w (:,:,:,t) = cplist_temp(:,:,:,1);
y_image_x (:,:,:,t) = cplist_temp(:,:,:,2);
y_image_y (:,:,:,t) = cplist_temp(:,:,:,3);

end
disp('Done!')

