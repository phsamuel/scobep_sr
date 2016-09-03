function [ Z0] = neighbor_weight( Z0, q,p, sigma,y,s,dx,dy,R_hat)
V = zeros(size(Z0));
W = zeros(size(Z0));

dx = -dx :1:dx;
dy = -dy :1:dy;

q2 = ceil(q/2);
R_hat2 = floor(R_hat/2);
R_hath = s*(R_hat-1)+1;

R_hat_Z1 = s*(5+R_hat2-1)+1;
R_hat_Z2 = s*(size(y,2)-R_hat2-1)+1;

% 
% for ii= 5+R_hat2  : size(y,2)-R_hat2
%     for jj = 5+R_hat2: size(y,2)-R_hat2
% %         
%        [V W,Z0] = Subpixel_register(Z0,y,ii,jj, dx ,dy,sigma,s,R_hath,p,q,V,W,Z0) ;
%               
%     end
% end


for k= R_hat_Z1  : R_hat_Z2
    for l = R_hat_Z1: R_hat_Z2
%         
       [V W,Z0] = Subpixel_register(Z0,y,k,l, dx ,dy,sigma,s,R_hath,p,q,V,W,Z0) ;
              
    end
end

 Z0 = V./W;



% for k=1 : size(dx,2)
%     for l = 1: size(dy,2)
%         %     Weighting  
%         for t = 1 : size(Y,3)
% %                       disp ([k l t kk ll])
%             YY = Y(kk+dx(k)-R_hat2:kk+dx(k)+R_hat2,ll+dy(l)-R_hat2:ll+dy(l)+R_hat2,t);
%             
% %             hb = imresize(hb,[p p],'bicubic');
% %             YY = y(kk+dx(k)-R_hat2:kk+dx(k)+R_hat2,ll+dy(l)-R_hat2:ll+dy(l)+R_hat2,t);
% %             
%             weight= exp(-norm(YY-hb)^2/(2*sigma*sigma));
%                   
%             
%             if(weight >0.5)
%                  disp(weight)
%             end
%             
%             
%             
%             
%             %  Inputs
%             id = floor((dx(k)+kk)/3);
%             jd = floor((dy(l)+ll)/3);
%             
%             % Update Inputs
%             R_Lij= y(id-q2:id+q2,jd-q2:jd+q2,1,t);
%             upb = upscale_block(R_Lij,s,p);
%             R_Hkl = Shift_image(upb, [dx(k) dy(l)]);
%             
%             V(kk-floor(p/2):kk+floor(p/2),ll-floor(p/2):ll+floor(p/2)) = V(kk-floor(p/2):kk+floor(p/2),ll-floor(p/2):ll+floor(p/2))...
%                 + weight * R_Hkl;
%             
%        
%             % Update Weight
%             R_Lijw= ones(q+1);
%             upbw = upscale_block(R_Lijw,s,p);
%             R_Hklw = Shift_image(upbw,[dx(k) dy(l)]);
%             
%             W(kk-floor(p/2):kk+floor(p/2),ll-floor(p/2):ll+floor(p/2))=W(kk-floor(p/2):kk+floor(p/2),ll-floor(p/2):ll+floor(p/2)) ...
%                 + weight * R_Hklw;
%         end
%     end
% %     imshow(V,[]);title(t);
% %             pause (0.01);
% end
% disp ([kk ll])
% z0 = V(ceil(p/2),ceil(p/2))/W(ceil(p/2),ceil(p/2));
end






function [upb] = upscale_block(lb,ds,p)
upb = zeros(p);
upb(1:ds:size(upb,1),1:ds:size(upb,2)) = lb;
end

function [image] = Shift_image(image,sh)

if sh(1)>0 % pad above
    image=[repmat(image(1,:),[sh(1),1]); image];
    image(size(image,1)-sh(1)+1:size(image,1),:)=[];
    image(1:sh(1),:)=0;
    
elseif sh(1)<0 % pad below
    image=[image; repmat(image(size(image,1),:),[-sh(1),1])];
    image(1:-sh(1),:)=[];
    image(end+sh(1)+1:end,:)=0;
end

if sh(2)>0 % pad left
    image=[repmat(image(:,1),[1,sh(2)]), image];
    image(:,size(image,2)-sh(2)+1:size(image,2))=[];
    image(:,1:sh(2))=0;
elseif sh(2)<0 % pad right
    image=[image, repmat(image(:,size(image,2)),[1,-sh(2)])];
    image(:,1:-sh(2))=[];
    image(:,end+sh(2)+1:end)=0;
end

end
