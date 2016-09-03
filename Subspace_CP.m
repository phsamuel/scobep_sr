
function [ cplist ] = Subspace_CP( dic,testIm,x,C_NO)

 K = 7;
for idr=1:size(testIm,1)
    for idc=1:size(testIm,2)
      
            y = testIm(idr,idc,:);
            y = reshape(y,[1 size(y,3)]);
            y = y';
            
            x1 = CSRec_SP(K,dic,y);
%             toc
            cplist(idr,idc,:,:) = CP_residual(dic, x1.x_hat, y,x,C_NO);
            %             x1 = CSRec_SP(K,dic,y);
%             cplist(idr,idc,:,:) = CP_residual(dic, x1.x_hat, y,x);
% toc
     end
%     disp([idr idc]);
end
end
