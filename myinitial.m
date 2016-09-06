function [Y] = myinitial (y,s)
% for i =1 : size(y,4)
  for i =1 : size(y,3)  
%     Y(:,:,i) = imresize(y(:,:,:,i),s,'lanczos3'); FORman
    Y(:,:,i) = imresize(y(:,:,i),s,'lanczos3');
    %         repmat
    %         temp = YY(:,:,i);
    %         temp = [repmat(temp(:,1),[1,k]), temp];
    %         temp=[temp, repmat(temp(:,size(temp,2)),[1,k])];
    %
    %         temp = [repmat(temp(1,:),[l,1]); temp];
    %         temp=[temp; repmat(temp(size(temp,1),:),[l,1])];
    %
    %         Y(:,:,i) = temp;
   end
end
