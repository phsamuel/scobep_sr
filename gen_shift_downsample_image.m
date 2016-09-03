function imout=gen_shift_downsample_image(image,k,l,ds,sh,R_hath)

% image=image(1:floor(size(image,1)/ds)*ds,1:floor(size(image,2)/ds)*ds);

image=shift_image(image,k,l,sh,R_hath);
imout = image;
% imout = imresize(image,ceil(size(image)/ds),'lanczos3');

% image=[image, repmat(image(:,size(image,2)),1)];
% image=[image, repmat(image(:,size(image,2)),1)];
% image=[image; repmat(image(size(image,1),:),1)];
% image=[image; repmat(image(size(image,1),:),1)];
% 
% imouts=ceil(size(image)/ds);
% 
% imout=zeros(imouts);
% for id=1:ds
%     for jd=1:ds
%         imout=imout+image(id:ds:size(image,1),jd:ds:size(image,2));
%     end
% end
% imout=imout/ds/ds;

