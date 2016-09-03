function [ V,W ] = general_subpixel_reg (Y,y,k,l,sigma,s,R_hath,V,W,hb,dx1,dy1,il,jl,t,h_image,kk,ll,weight_SCoBep)


R_hath2= floor(R_hath/2);





% for t = 1 : size(y,4)
for ii=1 : size(dx1,2)
    for jj = 1: size(dy1,2)
        
        % Weight
        %             h_image = hb(k-R_hath2:k+R_hath2,l-R_hath2 :l+R_hath2);
        Y_image = gen_shift_downsample_image(Y(:,:,t),k,l,s,[dx1(ii) dy1(jj)],R_hath);
        diff =  Y_image-h_image;
        
        temp = diff;
        temp = sum(sum((temp).^2));
        temp = sqrt (temp)/(2*sigma*sigma);
        weight = exp(-temp)*...
            sqrt(dx1(ii)^2+ dy1(jj)^2+(t-19)^2);
        
        % Update Inputs
%         y_image = y(il(ii),jl(jj),1,t );
         y_image = y(il(ii),jl(jj),t );
        scale = 1;%y_image/hb(kk,ll);
        
        %             disp([V(kk,ll)  W(kk,ll) ]);
        weight_SCoBep =1;
        V(kk,ll) = V(kk,ll)  + (weight * y_image)*scale*weight_SCoBep;
        
        % Update Weight
        W(kk,ll) = W(kk,ll) + weight*scale*weight_SCoBep;
        %              disp([V(kk,ll)  W(kk,ll) ]);
        if (W(kk,ll) < 0)
            disp (W(kk,ll))
        end
% %            disp([V(kk,ll) / W(kk,ll) weight weight_SCoBep])
    end
end

% end
end