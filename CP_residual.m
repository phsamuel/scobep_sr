%
%
%
function [X_hat] = CP_residual(dic, x1, y,x,C_NO)
% residuals = zeros(size(dic,2),1);
X_index = find(x1~=0);
X_value = x1(x1~=0);

% if (size(X_value,1)>10)
%     disp (X_value) ;
% end
X_hat = zeros(C_NO,3);
if (size(X_index,1)~=0)

for id=1: C_NO
    [cp, cpid] = max(abs(X_value));
%     func = sqrt((ddx(y_image_x(j,t)) - k)^2+ (ddy(y_image_y(j,t))-l)^2+(t-1)^2);
    X_hat(id,:) = [X_value(cpid)  mod(X_index(cpid)-1,x)+1,ceil(X_index(cpid)/x)];
    X_value(cpid) = 0;
end
end
% for id=1:size(dic,2)
%     x1_hat = x1(id);
% 
%     residuals(id) =  norm(y - dic(:,id) * x1_hat);
% 
% end


% max_residual = max(residuals);
% for id=1: C_NO
%     [cp, cpid] = min(residuals);
%     residual(id,:) = [max_residual-cp  mod(cpid-1,x)+1,ceil(cpid/x) x1(cpid)];
%     residuals(cpid) = nan;
% end
end
