function [ V,W ] = Subpixel_reg (Y,y,k,l,sigma,s,R_hath,V,W,hb,dx1,dy1,il,jl)


R_hath2= floor(R_hath/2);





for t = 1 : size(y,4)
    for ii=1 : size(dx1,2)
        for jj = 1: size(dy1,2)
            
            % Weight
            h_image = hb(k-R_hath2:k+R_hath2,l-R_hath2 :l+R_hath2);
            Y_image = gen_shift_downsample_image(Y(:,:,t),k,l,s,[dx1(ii) dy1(jj)],R_hath);
            diff =  Y_image-h_image;
            
            temp = diff;
            temp = sum(sum((temp).^2));
            temp = sqrt (temp)/(2*sigma*sigma);
            weight = exp(-temp)*...
                sqrt(dx1(ii)^2+ dy1(jj)^2+(t-1)^2);
            
            % Update Inputs
            y_image = y(il(ii),jl(jj),1,t );
            scale = y_image/hb(k,l);
            V(k,l) = V(k,l)  + (weight * y_image)*scale;
            
            % Update Weight
            W(k,l) = W(k,l) + weight*scale;
        end
    end
    
end
end



