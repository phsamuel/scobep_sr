function [ Z0 ] = findZ( Z0,Y,sigma,y,s,R_hat,Search_area,searchPixels,patchsize)

V = zeros(size(Z0));
W = zeros(size(Z0));
R_hath2= floor(R_hat/2);
R_hat_Z1 =  5+R_hath2; %   s*(5+R_hath2-1)+1;
R_hat_Z2 = size(Y,2)-R_hath2 ; %s*(size(Y,2)-R_hath2-1)+1;
hb = Z0;




% for k= R_hat_Z1  : R_hat_Z2-5
%     for l = R_hat_Z1: R_hat_Z2-5
%         % Using Elad paper for selecting Points
%         [dx1,dy1,il,jl] = Eladpoints(hb,k,l,s);
%
%
%         [ V,W ]= Subpixel_reg (Y,y,k,l,sigma,s,R_hat,V,W,hb,dx1,dy1,il,jl);
%
%     end
% end

%%% Using SCoBeP for selecting Points

% Forman
% k_s= 121 ;
% k_e =  279;
% l_s = 54;
% l_e = 203;


% k_s= 174 ;
% k_e =  210;
% l_s = 115;
% l_e =165;

% k_s= 174 ;
% k_e =  235;
% l_s = 115;
% l_e =293;

% 
k_s= 7 ;
k_e =  size(hb,1) -7;
l_s = 7;
l_e = size(hb,2)-7;


% % Bus
% k_s= 218+14+180 ;
% k_e =  678-50-100;
% l_s = 374+34  +37;
% l_e = 897-85-40;


% % % MIss
%  k_s= 15 ;
%  k_e =  255;
%  l_s = 15;
%  l_e = 174;


 Fout2 = Image2Block( hb, patchsize,k_s,k_e,l_s,l_e);
for t=1: size(Y,3)
    temp = Y(:,:,t);
    
    cplist_temp = SCoBeP(temp,Fout2,'BLOCK','SUBS','BP',patchsize,5e-2,7,15,10,Search_area);
    
%     filename=datestr(now);
%     filename(filename==' ')='_';
%     filename(filename==':')='_';
%     filename(filename=='-')='_';
%     save(strcat(filename,'_i',int2str(t),'.mat'),'cplist_temp','-v7.3');
    toc

    % Update Inputs
    y_image_w (:,:,:,t) = cplist_temp(:,:,:,1);
    y_image_x (:,:,:,t) = cplist_temp(:,:,:,2);
    y_image_y (:,:,:,t) = cplist_temp(:,:,:,3);
    
end


filename=datestr(now);
    filename(filename==' ')='_';
    filename(filename==':')='_';
    filename(filename=='-')='_';
    save(strcat(filename,'xyw','.mat'),'y_image_w','y_image_x','y_image_y','-v7.3');
   



%  load '10_Apr_2013_11_13_35xyw.mat';


        tic
        [ V,W ] = SCoBePpoints( hb,k_s,k_e,l_s,l_e,s,y,R_hat,V,W,sigma,y_image_w,y_image_x,y_image_y,Y,patchsize,Search_area,searchPixels );
        toc



 Z0(k_s:k_e,l_s:l_e) = V(k_s:k_e,l_s:l_e)./W(k_s:k_e,l_s:l_e);

   
 
%  for g=1:60;
%      for f=1: 60
%    elad = PSNR(double(Elad(k_s+g:k_e-f,l_s+g:l_e-f)),double(gt(k_s+g:k_e-f,l_s+g:l_e-f)));
%     nafiss =PSNR(double(Z0(k_s+g:k_e-f,l_s+g:l_e-f)),double(gt(k_s+g:k_e-f,l_s+g:l_e-f))) ;
%     if (nafiss> elad)
%        disp ([g f]) ;
%     end
%      end
    
%  end

end


function [dx1,dy1,il,jl] = Eladpoints(hb,k,l,s)

dd = 2:3:size(hb,1);
if (size(find(dd==k),2) == 0 )
    ff = find(dd<k,1,'last');
    ee = find(dd>k,1,'first');
    f= ff*s-1;
    e=ee*s-1;
    dx1 = [f-k e-k];
else
    %     dx1 = [-3 0 3];
    dx1 = 0;
end

dd = 2:3:size(hb,2);
if (size(find(dd==l),2) == 0 )
    ff = find(dd<l,1,'last');
    ee = find(dd>l,1,'first');
    f= ff*s-1;
    e=ee*s-1;
    dy1 = [f-l e-l];
else
    %     dy1 = [-3 0 3];
    dy1 = 0;
end

% Finding pints in Low image
il = (k + dx1+1)/s;
jl = (l + dy1+1)/s;
end

function [diffxy,id,jd] = ScoBePpoints(testIm,gapsize,s)

[x y z] = size(testIm);
ddx = 2:s:size(testIm,1);
xx= 1+gapsize;
ff = find(ddx>xx,1,'first');
f= ff*s-1;



ddy = 2:s:size(testIm,2);
yy = x-gapsize;
ee = find(ddy<yy,1,'last');
e= ee*s-1;


jd=f:s:e;
id=f :s: e;

diffx=  (id(1)-ddx(1))/s;
diffy= (jd(1)-ddy(1))/s;
diffxy = [diffx diffy];
end


%  1
%     load '02_Aug_2011_09_46_09_i1.mat'
%    y_image_w (:,:,:,1) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,1) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,1) = cplist_temp(:,:,:,3);
%  
%    
% %  2
%     load '02_Aug_2011_10_23_38_i2.mat'
%    y_image_w (:,:,:,2) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,2) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,2) = cplist_temp(:,:,:,3);
%  
% %  3
%     load '02_Aug_2011_11_02_42_i3.mat'
%    y_image_w (:,:,:,3) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,3) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,3) = cplist_temp(:,:,:,3);
%  
%    
%   %  4
%     load '02_Aug_2011_11_42_13_i4.mat'
%    y_image_w (:,:,:,4) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,4) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,4) = cplist_temp(:,:,:,3);
%  
% %  5
%     load '02_Aug_2011_12_21_19_i5.mat'
%    y_image_w (:,:,:,5) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,5) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,5) = cplist_temp(:,:,:,3);
%  
% %  6
%     load '02_Aug_2011_13_01_09_i6.mat'
%    y_image_w (:,:,:,6) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,6) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,6) = cplist_temp(:,:,:,3);
%  
% %  7
%     load '02_Aug_2011_13_40_37_i7.mat'
%    y_image_w (:,:,:,7) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,7) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,7) = cplist_temp(:,:,:,3);
%  
% %  8
%     load '02_Aug_2011_14_20_09_i8.mat'
%    y_image_w (:,:,:,8) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,8) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,8) = cplist_temp(:,:,:,3);
%  
%  %  9
%     load '02_Aug_2011_14_59_40_i9.mat'
%    y_image_w (:,:,:,9) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,9) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,9) = cplist_temp(:,:,:,3);
%  
% %  10
%     load '02_Aug_2011_15_40_00_i10.mat'
%    y_image_w (:,:,:,10) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,10) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,10) = cplist_temp(:,:,:,3);
%  
% %  11
%     load '02_Aug_2011_16_20_25_i11.mat'
%    y_image_w (:,:,:,11) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,11) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,11) = cplist_temp(:,:,:,3);
%  
% %  12
%     load '02_Aug_2011_17_00_28_i12.mat'
%    y_image_w (:,:,:,12) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,12) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,12) = cplist_temp(:,:,:,3);
%  
% %  13
%     load '02_Aug_2011_17_40_27_i13.mat'
%    y_image_w (:,:,:,13) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,13) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,13) = cplist_temp(:,:,:,3);
%  
% %  14
%     load '02_Aug_2011_18_20_18_i14.mat'
%    y_image_w (:,:,:,14) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,14) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,14) = cplist_temp(:,:,:,3);
%  
% %  15
%     load '02_Aug_2011_19_00_31_i15.mat'
%    y_image_w (:,:,:,15) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,15) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,15) = cplist_temp(:,:,:,3);
%  
% %  16
%     load '02_Aug_2011_19_40_27_i16.mat'
%    y_image_w (:,:,:,16) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,16) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,16) = cplist_temp(:,:,:,3);
%  
% %  17
%     load '01_Aug_2011_11_45_05_i17.mat'
%    y_image_w (:,:,:,17) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,17) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,17) = cplist_temp(:,:,:,3);
%  
% %  18
%     load '01_Aug_2011_12_25_27_i18.mat'
%    y_image_w (:,:,:,18) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,18) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,18) = cplist_temp(:,:,:,3);
%  
% %  19
%     load '01_Aug_2011_13_06_25_i19.mat'
%    y_image_w (:,:,:,19) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,19) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,19) = cplist_temp(:,:,:,3);
%  
% %  20
%     load '01_Aug_2011_13_48_06_i20.mat'
%    y_image_w (:,:,:,20) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,20) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,20) = cplist_temp(:,:,:,3);
%  
% %  21
%     load '01_Aug_2011_14_22_11_i21.mat'
%    y_image_w (:,:,:,21) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,21) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,21) = cplist_temp(:,:,:,3);
%  
% %  22
%     load '01_Aug_2011_14_56_01_i22.mat'
%    y_image_w (:,:,:,22) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,22) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,22) = cplist_temp(:,:,:,3);
%  
% %  23
%     load '01_Aug_2011_15_30_16_i23.mat'
%    y_image_w (:,:,:,23) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,23) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,23) = cplist_temp(:,:,:,3);
%  
% %  24
%     load '01_Aug_2011_16_12_07_i24.mat'
%    y_image_w (:,:,:,24) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,24) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,24) = cplist_temp(:,:,:,3);
%  
% %  25
%     load '01_Aug_2011_16_53_42_i25.mat'
%    y_image_w (:,:,:,25) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,25) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,25) = cplist_temp(:,:,:,3);
%  
% %  26
%     load '01_Aug_2011_17_35_11_i26.mat'
%    y_image_w (:,:,:,26) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,26) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,26) = cplist_temp(:,:,:,3);
%  
% %  27
%     load '01_Aug_2011_18_17_26_i27.mat'
%    y_image_w (:,:,:,27) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,27) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,27) = cplist_temp(:,:,:,3);
%  
% %  28
%     load '01_Aug_2011_18_58_52_i28.mat'
%    y_image_w (:,:,:,28) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,28) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,28) = cplist_temp(:,:,:,3);
%  
% %  29
%     load '01_Aug_2011_19_40_04_i29.mat'
%    y_image_w (:,:,:,29) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,29) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,29) = cplist_temp(:,:,:,3);
%    
%  %  30
%     load '01_Aug_2011_20_21_25_i30.mat'
%    y_image_w (:,:,:,30) = cplist_temp(:,:,:,1);
%    y_image_x (:,:,:,30) = cplist_temp(:,:,:,2);
%    y_image_y (:,:,:,30) = cplist_temp(:,:,:,3);  
% 
% 
% save( '02_Aug_2011_19_40_27xyw-90-212-45-212-patchsize13.mat', 'y_image_w','y_image_x','y_image_y','-v7.3')
