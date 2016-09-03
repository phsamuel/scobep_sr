% clear
% figure;
% % Miss America
% k_s= 7+20 ;
% k_e =  262-20;
% l_s = 7+20;
% l_e = 182-20;
% 
% %  k_s= 15 ;
% %  k_e =  255;
% %  l_s = 15;
% %  l_e = 174;
% 
% 
% load 'Aram/MissAmerica_SR.mat';
% load 'MissAmerica_Elad/miss_Elad.mat';
% load 'MissAmerica_Z0/miss_Z0_DEB.mat';
% load 'MissAmerica/miss_bicubic.mat';
% load 'MissAmerica/miss_bilinear.mat';
% load 'MissAmerica/miss_lanczos3.mat';
% load 'MissAmerica/miss_nearest.mat';
% 
% for t = 1:size(miss_Z0,3)
%    disp(t);
%     Z0 = miss_Z0(:,:,t);
%     gt = double(y_ground_truth(:,:,t));
%     elad = double (Elad (:,:,t));
%     aram = double(y_reconstructed(:,:,t));
%     Mbicubic = double(miss_bicubic(:,:,t));
%     Mbilinear = double(miss_bilinear(:,:,t));
%     Mlanczos3 = double(miss_lanczos3(:,:,t));
%     Mnearest = double(miss_nearest(:,:,t));
%     
%     
%     gt= gt(k_s:k_e,l_s:l_e);
%     elad = elad(k_s:k_e,l_s:l_e);
%     Z0 = Z0(k_s:k_e,l_s:l_e);
%     aram = aram(k_s:k_e,l_s:l_e);
%     Mlanczos3 = Mlanczos3(k_s:k_e,l_s:l_e);
%     Mbilinear = Mbilinear(k_s:k_e,l_s:l_e);
%     Mbicubic = Mbicubic(k_s:k_e,l_s:l_e);
%     Mnearest = Mnearest(k_s:k_e,l_s:l_e);
% %     
%     missA_Z0(t)= PSNR (Z0 , gt);
%     missA_Elad(t)= PSNR (elad , gt);
%     missA_Aram(t) = PSNR(aram,gt);
%     missA_lanczos3(t) = PSNR(Mlanczos3,gt);
%     missA_bilinear(t) = PSNR(Mbilinear,gt);
%     missA_bicubic(t) = PSNR(Mbicubic,gt);
%     missA_nearest(t) = PSNR(Mnearest,gt);
%     
%     missA_Z0_s(t)= ssim (Z0 , gt);
%     missA_Elad_s(t)= ssim (elad , gt);
%     missA_Aram_s(t) = ssim(aram,gt);
%     missA_lanczos3_s(t) = ssim(Mlanczos3,gt);
%     missA_bilinear_s(t) = ssim(Mbilinear,gt);
%     missA_bicubic_s(t) = ssim(Mbicubic,gt);
%     missA_nearest_s(t) = ssim(Mnearest,gt);
% %  
% end
% % 
% % avgZ0 = mean(missA_Z0);
% % avgElad = mean(missA_Elad);
% % avgAram = mean(missA_Aram);
% % avglanczos3 = mean(missA_lanczos3);
% % avgbilinear = mean(missA_bilinear);
% % avgbicubic = mean(missA_bicubic);
% % avgnearest = mean(missA_nearest);
% % 
% % 
% avgZ0_s = mean(missA_Z0_s)
%  avgElad_s = mean(missA_Elad_s)
% %  avgAram_s = mean(missA_Aram_s);
% % avglanczos3_s = mean(missA_lanczos3_s);
% % avgbilinear_s = mean(missA_bilinear_s);
% % avgbicubic_s = mean(missA_bicubic_s);
% % avgnearest_s = mean(missA_nearest_s);
% 
% % avr = [ avgZ0_s avgElad_s avgAram_s avglanczos3_s avgbilinear_s avgbicubic_s];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% 
% % avr = [ avgZ0 avgElad avgAram avglanczos3 avgbilinear avgbicubic avgnearest];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% 
% 
% % figure;
% % 
% % 
% % avr = [ avgZ0 avgElad avgbilinear avglanczos3 avgnearest];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% % 
% % 
% % figure;
% % x = [1:size(missA_Z0,2)];
% % plot(x,missA_Z0,'bs-',x,missA_Elad,'-xr',x,missA_Aram,'+m-',x,missA_lanczos3,'*b--',x,missA_bilinear,'*r--',x,missA_bicubic,'*m--',x,missA_nearest,'*b--')
% % 
% % grid on
% % h_legend = legend('SCoBeP','Elad','Aram','lanczos3','bilinear','bicubic','nearest','Location','NorthEast')
% % 
% 
% figure;
% x = [1:size(missA_Z0,2)];
% plot(x,missA_bilinear,'g-o',x,missA_Elad,'r-v',x,missA_Z0,'bs-','LineWidth',2,'MarkerSize',8)
% 
% ylabel('Peak Signal to Noise Ratio [dB]')
% xlabel('Time')
% 
% grid on
% h_legend = legend('lanczos','GNL-Means','SCoBeP-SR','Location','NorthEast')
% 
% 
% figure;
% x = [1:size(missA_Z0,2)];
% plot(x,missA_bilinear_s,'g-o',x,missA_Elad_s,'r-v',x,missA_Z0_s,'bs-','LineWidth',2,'MarkerSize',8)
% 
% ylabel('Peak Signal to Noise Ratio [dB]')
% xlabel('Time')
% 
% grid on
% h_legend = legend('lanczos','GNL-Means','SCoBeP-SR','Location','NorthEast')
% 
% 
% 
% 
% 
% 
% clear
% figure;
% % % Foreamn
% k_s= 121 ;
% k_e =  279;
% l_s = 54;
% l_e = 203;
% 
% k_s= 15 ;
% k_e =  273;
% l_s = 15;
% l_e = 297;
% 
% 
% load 'Aram/Foreman_SR.mat';
% load 'Foreman_Elad/foreman_Elad.mat';
% load 'Foreman_Z0/Foreman_Z0_Deb.mat';
% load 'Foreman/foreman_bicubic.mat';
% load 'Foreman/foreman_bilinear.mat';
% load 'Foreman/foreman_lanczos3.mat';
% load 'Foreman/foreman_nearest.mat';
% 
% for t = 1:size(Foreman_Z0_Deb,3)
%    disp(t);
%     Z0 = Foreman_Z0_Deb(:,:,t);
%     gt = double(y_ground_truth(:,:,t));
%     elad = double (Elad (:,:,t));
%     aram = double(y_reconstructed(:,:,t));
%     Mbicubic = double(foreman_bicubic(:,:,t));
%     Mbilinear = double(foreman_bilinear(:,:,t));
%     Mlanczos3 = double(foreman_lanczos3(:,:,t));
%     Mnearest = double(foreman_nearest(:,:,t));
%     
% %     gt= gt(k_s:k_e,l_s:l_e);
% %     elad = elad(k_s:k_e,l_s:l_e);
% %     Z0 = Z0(k_s:k_e,l_s:l_e);
% %     aram = aram(k_s:k_e,l_s:l_e);
% %     Mlanczos3 = Mlanczos3(k_s:k_e,l_s:l_e);
% %     Mbilinear = Mbilinear(k_s:k_e,l_s:l_e);
% %     Mbicubic = Mbicubic(k_s:k_e,l_s:l_e);
%     
%     ForeMan_Z0(t)= PSNR (Z0 , gt);
%     ForeMan_Elad(t)= PSNR (elad , gt);
%     ForeMan_Aram(t) = PSNR(aram,gt);
%     ForeMan_lanczos3(t) = PSNR(Mlanczos3,gt);
%     ForeMan_bilinear(t) = PSNR(Mbilinear,gt);
%     ForeMan_bicubic(t) = PSNR(Mbicubic,gt);
%     ForeMan_nearest(t) = PSNR(Mnearest,gt);
%     
%     ForeMan_Z0_s(t)= ssim (Z0 , gt);
%     ForeMan_Elad_s(t)= ssim (elad , gt);
%     ForeMan_Aram_s(t) = ssim(aram,gt);
%     ForeMan_lanczos3_s(t) = ssim(Mlanczos3,gt);
%     ForeMan_bilinear_s(t) = ssim(Mbilinear,gt);
%     ForeMan_bicubic_s(t) = ssim(Mbicubic,gt);
%     ForeMan_nearest_s(t) = ssim(Mnearest,gt);
%     
%     
%  
% end
% 
% 
% % avgZ0 = mean(ForeMan_Z0);
% % avgElad = mean(ForeMan_Elad);
% % avgAram = mean(ForeMan_Aram);
% % avglanczos3 = mean(ForeMan_lanczos3);
% % avgbilinear = mean(ForeMan_bilinear);
% % avgbicubic = mean(ForeMan_bicubic);
% % avgnearest = mean(ForeMan_nearest);
% % 
% % 
% % avgZ0_s = mean(ForeMan_Z0_s);
% % avgElad_s = mean(ForeMan_Elad_s);
% % avgAram_s = mean(ForeMan_Aram_s);
% % avglanczos3_s = mean(ForeMan_lanczos3_s);
% % avgbilinear_s = mean(ForeMan_bilinear_s);
% % avgbicubic_s = mean(ForeMan_bicubic_s);
% % avgnearest_s = mean(ForeMan_nearest_s);
% % 
% % avr = [ avgZ0_s avgElad_s avgAram_s avglanczos3_s avgbilinear_s avgbicubic_s];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% % 
% % figure;
% % 
% % 
% % avr = [ avgZ0 avgElad avgAram avglanczos3 avgbilinear avgbicubic];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% % 
% % figure;
% % 
% % avrs = [ avgZ0_s avgElad_s avgbilinear_s avglanczos3_s avgnearest_s];
% % 
% % x = [1:size(avrs,2)];
% % plot(x,avrs,'bs-')
% % 
% % grid on
% % 
% % 
% % figure;
% % 
% % avr = [ avgZ0 avgElad avgbilinear avglanczos3 avgnearest];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% % 
% % 
% % figure;
% % 
% 
% 
% 
% % x = [1:size(ForeMan_Z0,2)];
% % plot(x,ForeMan_Z0,'bs-',x,ForeMan_Elad,'-xr',x,ForeMan_Aram,'+m-',x,ForeMan_lanczos3,'*b--',x,ForeMan_bilinear,'+r--',x,ForeMan_bicubic,'*m--',x,ForeMan_nearest,'>b--')
% % 
% % grid on
% % h_legend = legend('SCoBeP','Elad','Aram','lanczos3','bilinear','bicubic','Location','North')
% % 
% 
% figure;
% 
% x = [1:size(ForeMan_Z0,2)];
% plot(x,ForeMan_bilinear,'g-o',x,ForeMan_Elad,'r-v',x,ForeMan_Z0,'bs-','LineWidth',2,'MarkerSize',8)
% 
% ylabel('Peak Signal to Noise Ratio [dB]')
% xlabel('Time')
% 
% grid on
% h_legend = legend('Lanczos','GNL-Means','SCoBeP-SR','Location','NorthEast')
% 
% 
% % avr = [ avgZ0_s avgElad_s avgAram_s avglanczos3_s avgbilinear_s avgbicubic_s];
% % 
% % x = [1:size(avr,2)];
% % plot(x,avr,'bs-')
% % 
% % grid on
% 
% 
% 
% 
% 
% figure;
% 
% x = [1:size(ForeMan_Z0,2)];
% plot(x,ForeMan_bilinear_s,'g-o',x,ForeMan_Elad_s,'r-v',x,ForeMan_Z0_s,'bs-','LineWidth',2,'MarkerSize',8)
% 
% ylabel('Peak Signal to Noise Ratio [dB]')
% xlabel('Time')
% 
% grid on
% h_legend = legend('Lanczos','GNL-Means','SCoBeP-SR','Location','NorthEast')
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 



clear
% figure;
% Suzie
k_s= 1 ;
k_e =  240;
l_s = 1;
l_e = 351;

%  k_s= 15 ;
%  k_e =  255;
%  l_s = 15;
%  l_e = 174;


load 'Aram/Suzie_SR.mat';
load 'Suzie_Elad/Suzie_Elad.mat';
load 'Suzie_Z0/Suzie_Z0_DEB.mat';
load 'Suzie/Suzie_bicubic.mat';
load 'Suzie/Suzie_bilinear.mat';
load 'Suzie/Suzie_lanczos3.mat';
load 'Suzie/Suzie_nearest.mat';

for t = 1:size(Suzie_Z0,3)
   disp(t);
    Z0 = Suzie_Z0(:,:,t);
    gt = double(y_ground_truth(:,:,t));
    elad = double (Elad (:,:,t));
    aram = double(y_reconstructed(:,:,t));
    Mbicubic = double(Suzie_bicubic(:,:,t));
    Mbilinear = double(Suzie_bilinear(:,:,t));
    Mlanczos3 = double(Suzie_lanczos(:,:,t));
    Mnearest = double(Suzie_nearest(:,:,t));
    
    
    gt= gt(k_s:k_e,l_s:l_e);
    elad = elad(k_s:k_e,l_s:l_e);
    Z0 = Z0(k_s:k_e,l_s:l_e);
    aram = aram(k_s:k_e,l_s:l_e);
    Mlanczos3 = Mlanczos3(k_s:k_e,l_s:l_e);
    Mbilinear = Mbilinear(k_s:k_e,l_s:l_e);
    Mbicubic = Mbicubic(k_s:k_e,l_s:l_e);
    Mnearest = Mnearest(k_s:k_e,l_s:l_e);
%     
    SuzieA_Z0(t)= PSNR (Z0 , gt);
    SuzieA_Elad(t)= PSNR (elad , gt);
    SuzieA_Aram(t) = PSNR(aram,gt);
    SuzieA_lanczos3(t) = PSNR(Mlanczos3,gt);
    SuzieA_bilinear(t) = PSNR(Mbilinear,gt);
    SuzieA_bicubic(t) = PSNR(Mbicubic,gt);
    SuzieA_nearest(t) = PSNR(Mnearest,gt);
    
    SuzieA_Z0_s(t)= ssim (Z0 , gt);
    SuzieA_Elad_s(t)= ssim (elad , gt);
    SuzieA_Aram_s(t) = ssim(aram,gt);
    SuzieA_lanczos3_s(t) = ssim(Mlanczos3,gt);
    SuzieA_bilinear_s(t) = ssim(Mbilinear,gt);
    SuzieA_bicubic_s(t) = ssim(Mbicubic,gt);
    SuzieA_nearest_s(t) = ssim(Mnearest,gt);
%  
end
% 
avgZ0 = mean(SuzieA_Z0);
avgElad = mean(SuzieA_Elad);
avgAram = mean(SuzieA_Aram);
avglanczos3 = mean(SuzieA_lanczos3);
avgbilinear = mean(SuzieA_bilinear);
avgbicubic = mean(SuzieA_bicubic);
avgnearest = mean(SuzieA_nearest);
% 
% 
% avgZ0_s = mean(SuzieA_Z0_s);
% avgElad_s = mean(SuzieA_Elad_s);
% avgAram_s = mean(SuzieA_Aram_s);
% avglanczos3_s = mean(SuzieA_lanczos3_s);
% avgbilinear_s = mean(SuzieA_bilinear_s);
% avgbicubic_s = mean(SuzieA_bicubic_s);
% avgnearest_s = mean(SuzieA_nearest_s);

% avr = [ avgZ0_s avgElad_s avgAram_s avglanczos3_s avgbilinear_s avgbicubic_s];
% 
% x = [1:size(avr,2)];
% plot(x,avr,'bs-')
% 
% grid on

avr = [ avgZ0 avgElad avgAram avglanczos3 avgbilinear avgbicubic avgnearest];

x = [1:size(avr,2)];
plot(x,avr,'bs-')

grid on


% figure;
% 
% 
% avr = [ avgZ0 avgElad avgbilinear avglanczos3 avgnearest];
% 
% x = [1:size(avr,2)];
% plot(x,avr,'bs-')
% 
% grid on
% 

% figure;
% x = [1:size(SuzieA_Z0,2)];
% plot(x,SuzieA_Z0,'bs-',x,SuzieA_Elad,'-xr',x,SuzieA_Aram,'+m-',x,SuzieA_lanczos3,'*b--',x,SuzieA_bilinear,'*r--',x,SuzieA_bicubic,'*m--',x,SuzieA_nearest,'*b--')
% 
% grid on
% h_legend = legend('SCoBeP','Elad','Aram','lanczos3','bilinear','bicubic','nearest','Location','NorthEast')


figure;
x = [1:size(SuzieA_Z0,2)];
plot(x,SuzieA_bilinear,'g-o',x,SuzieA_Elad,'r-v',x,SuzieA_Z0,'bs-','LineWidth',2,'MarkerSize',8)

ylabel('Peak Signal to Noise Ratio [dB]')
xlabel('Time')

grid on
h_legend = legend('lanczos','GNL-Means','SCoBeP-SR','Location','East')

% 
figure;
x = [1:size(SuzieA_Z0,2)];
plot(x,SuzieA_bilinear_s,'g-o',x,SuzieA_Elad_s,'r-v',x,SuzieA_Z0_s,'bs-','LineWidth',2,'MarkerSize',8)

ylabel('Peak Signal to Noise Ratio [dB]')
xlabel('Time')

grid on
h_legend = legend('lanczos','GNL-Means','SCoBeP-SR','Location','NorthEast')
% 



% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % 
% % dirfiles = dir ('./Suzie_Elad/*.tif');
% % for j =1 : length(dirfiles)
% %    str = strcat('./Suzie_Elad/', dirfiles(j).name);
% %    Im2 = imread(str);
% %    Elad(:,:,j) = Im2;
% % end
% % 
% % save(Elad);
% 
% 
% 
% 
% % for j =1 : 30
% %     gt = double(y_observation(:,:,j));
% %      Im2 = imresize(gt,3,'bicubic');
% %     Suzie_bicubic(:,:,j) = Im2;
% % endPlot_SRs
% 
% 
% % 
% % 
% % load 'U2_Suzie_frame1.mat'
% % Suzie_Z0_DEB (:,:,1) = U2;
% % load 'U2_Suzie_frame2.mat'
% % Suzie_Z0_DEB (:,:,2) = U2;
% % load 'U2_Suzie_frame3.mat'
% % Suzie_Z0_DEB (:,:,3) = U2;
% % load 'U2_Suzie_frame4.mat'
% % Suzie_Z0_DEB (:,:,4) = U2;
% % load 'U2_Suzie_frame5.mat'
% % Suzie_Z0_DEB (:,:,5) = U2;
% % load 'U2_Suzie_frame6.mat'
% % Suzie_Z0_DEB (:,:,6) = U2;
% % load 'U2_Suzie_frame7.mat'
% % Suzie_Z0_DEB (:,:,7) = U2;
% % load 'U2_Suzie_frame8.mat'
% % Suzie_Z0_DEB (:,:,8) = U2;
% % load 'U2_Suzie_frame9.mat'
% % Suzie_Z0_DEB (:,:,9) = U2;
% % load 'U2_Suzie_frame10.mat'
% % Suzie_Z0_DEB (:,:,10) = U2;
% % load 'U2_Suzie_frame11.mat'
% % Suzie_Z0_DEB (:,:,11) = U2;
% % load 'U2_Suzie_frame12.mat'
% % Suzie_Z0_DEB (:,:,12) = U2;
% % load 'U2_Suzie_frame13.mat'
% % Suzie_Z0_DEB (:,:,13) = U2;
% % load 'U2_Suzie_frame14.mat'
% % Suzie_Z0_DEB (:,:,14) = U2;
% % load 'U2_Suzie_frame15.mat'
% % Suzie_Z0_DEB (:,:,15) = U2;
% % load 'U2_Suzie_frame16.mat'
% % Suzie_Z0_DEB (:,:,16) = U2;
% % load 'U2_Suzie_frame17.mat'
% % Suzie_Z0_DEB (:,:,17) = U2;
% % load 'U2_Suzie_frame18.mat'
% % Suzie_Z0_DEB (:,:,18) = U2;
% % load 'U2_Suzie_frame19.mat'
% % Suzie_Z0_DEB (:,:,19) = U2;
% % load 'U2_Suzie_frame20.mat'
% % Suzie_Z0_DEB (:,:,20) = U2;
% % load 'U2_Suzie_frame21.mat'
% % Suzie_Z0_DEB (:,:,21) = U2;
% % load 'U2_Suzie_frame22.mat'
% % Suzie_Z0_DEB (:,:,22) = U2;
% % load 'U2_Suzie_frame23.mat'
% % Suzie_Z0_DEB (:,:,23) = U2;
% % load 'U2_Suzie_frame24.mat'
% % Suzie_Z0_DEB (:,:,24) = U2;
% % load 'U2_Suzie_frame25.mat'
% % Suzie_Z0_DEB (:,:,25) = U2;
% % load 'U2_Suzie_frame26.mat'
% % Suzie_Z0_DEB (:,:,26) = U2;
% % load 'U2_Suzie_frame27.mat'
% % Suzie_Z0_DEB (:,:,27) = U2;
% % load 'U2_Suzie_frame28.mat'
% % Suzie_Z0_DEB (:,:,28) = U2;
% % load 'U2_Suzie_frame29.mat'
% % Suzie_Z0_DEB (:,:,29) = U2;
% % load 'U2_Suzie_frame30.mat'
% % Suzie_Z0_DEB (:,:,30) = U2;
% 
% % 
% % 
% 
