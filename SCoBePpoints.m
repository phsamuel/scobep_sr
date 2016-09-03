function [ V,W ] = SCoBePpoints(hb,k_s,k_e,l_s,l_e,s,y,R_hath,V,W,sigma,y_image_w,y_image_x,y_image_y,YY,patchsize,Search_area,searchPixels )
%   if (k==168 && l== 100 )
%      disp(k)
%  end
for k = k_s : k_e
    for l= l_s : l_e
        R_hath2= floor(R_hath/2);
%         if (k==99 && l == 182)
%             disp ([k l])
        
        temp = hb(k-patchsize:k+patchsize,l-patchsize :l+patchsize);
        h_image = temp;
        
        % Finding Candidate Points
        %     tic
        %     cplist_all = SCoBeP( h_image,'BLOCK','SUBS','BP',patchsize,dic,gsize,5e-2,7,15,10);%,patchsize,tolerance,C_NO,iter_size,Sigma2)
        %      toc
        %     cplist = reshape (cplist_all, size(cplist_all,3),size(cplist_all,4),size(cplist_all,5));
        %
        %     % Update Inputs
        %     y_image_w = reshape(cplist(:,1,:), [size(cplist(:,1,:),1),size(cplist(:,1,:),3)]);
        %     y_image_x = reshape(cplist(:,2,:), [size(cplist(:,2,:),1),size(cplist(:,2,:),3)])+patchsize+Search_area;
        %     y_image_y = reshape(cplist(:,3,:), [size(cplist(:,3,:),1),size(cplist(:,3,:),3)])+patchsize+Search_area;
        %
%         disp ([k l])
        Yw = reshape(y_image_w (k-k_s + 1,l-l_s+1,:,:), size(y_image_w,3),size(y_image_w,4));
        Yx = reshape(y_image_x (k-k_s + 1,l-l_s+1,:,:), size(y_image_w,3),size(y_image_w,4))+patchsize+Search_area;
        Yy = reshape(y_image_y (k-k_s + 1,l-l_s+1,:,:), size(y_image_w,3),size(y_image_w,4))+patchsize+Search_area;
        
        Yws = Yw;
        
        y_w = zeros(size(Yx));
        h_image = hb(k-R_hath2:k+R_hath2,l-R_hath2 :l+R_hath2);
        
        for t = 1 : size(Yx,2)
            %     y_image(:,t) = sum(eye(size(Yx,1)) .* y(Yx(:,t), Yy(:,t),1,t))';
            for j = 1 : size(Yx,1)
                % Finding at least 4 points around each candidate point
                [dx1,dy1,il,jl] = Eladpoints(hb,Yx(j,t),Yy(j,t),s,searchPixels);
                if (Yx(j,t)==55 && Yy(j,t) == 67)
                    disp([Yx(j,t)  Yy(j,t)])
                end
                if (Yx(j,t)<R_hath2-min(dx1) || Yx(j,t)>size(YY,1)-R_hath2-max(dx1) || Yy(j,t)<R_hath2-min(dy1) ||Yy(j,t)>size(YY,2)-R_hath2-max(dy1)|| Yw(j,t) == 0 )
                    continue;
                else
                    %             disp([Yx(j,t) Yy(j,t) k l])
                    %Updating V & W for [k,l]
                    if (Yx(j,t)==36&& Yy(j,t)==241)
                    disp ([Yx(j,t) Yy(j,t)])
                    end
                    [ V,W ] = general_subpixel_reg (YY,y,Yx(j,t),Yy(j,t),sigma,s,R_hath,V,W,hb,dx1,dy1,il,jl,t,h_image,k,l,Yw(j,t));
                    %             disp (V(k,l)/W(k,l))
%                     toc
                end
            end
            
%         end
%         toc
        end
    end
end

end
%  end


function [dx1,dy1,il,jl] = Eladpoints(hb,k,l,s,searchPixels)

dd = 2:3:size(hb,1);
if (size(find(dd==k),2) == 0 )
    ff = find(dd<k,1,'last');
    ee = find(dd>k,1,'first');
    f= ff*s-1;
    e=ee*s-1;
    dx1 = [f-k e-k];
%     dx1 = [sort(f-k:-s:f-k-searchPixels) e-k:s:e-k+searchPixels];
else
    dx1 = [-3 0 3];
    % dx1 = 0;
end

dd = 2:3:size(hb,2);
if (size(find(dd==l),2) == 0 )
    ff = find(dd<l,1,'last');
    ee = find(dd>l,1,'first');
    f= ff*s-1;
    e=ee*s-1;
    dy1 = [f-l e-l];
%     dy1 = [sort(f-l:-s:f-l-searchPixels) e-l:s:e-l+searchPixels];
else
    dy1 = [-3 0 3];
    %dy1 = 0;
end

% Finding pints in Low image
il = (k + dx1+1)/s;
jl = (l + dy1+1)/s;
end


function imout = downsam(image, ds)

imouts=ceil(size(image)/ds);

imout=zeros(imouts);
for id=1:ds
    for jd=1:ds
        imout=imout+image(id:ds:size(image,1),jd:ds:size(image,2));
    end
end
imout=imout/ds/ds;

end