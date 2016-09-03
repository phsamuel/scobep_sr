function image = shift_image(image,k,l,sh,R_hath)

R_hath2= floor(R_hath/2);
image = image (k+sh(1)-R_hath2: k+sh(1)+R_hath2 , l+sh(2)-R_hath2 : l+sh(2)+R_hath2 );

end

