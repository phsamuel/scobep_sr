function cplist =SCoBeP(I1,Fout2,feature,similarity,reconst,patchsize,tolerance,C_NO,iter_size,Sigma2,Search_area)
%% Step 1. Load and downsample the images


refIm =I1;
% testIm =I2;
%     subplot(2,2,1);imshow(refIm,[]);title('reference image');
%     subplot(2,2,2);imshow(testIm,[]);title('test image');
% for t = 1 : size(dicAll,1)
%% Step 2. Extract Features
if      strcmp(feature,'SIFT')
    %patchsize=8;
    gridspacing=1;
    Fout1=dense_sift(refIm,patchsize,gridspacing);
    [x y z] = size(Fout1);
    Fout2=dense_sift(testIm,patchsize,gridspacing);
    patchsize = 3;
    x_gsize = x ;
elseif  strcmp(feature,'BLOCK')
    %patchsize = 3;
    Fout1 = Image2Block_Y(refIm,patchsize,Search_area);
%     filename=datestr(now);
%     filename(filename==' ')='_';
%     filename(filename==':')='_';
%     filename(filename=='-')='_';
%     save(strcat(filename,'_i','.mat'),'Fout1','-v7.3');
    [x y z] = size(Fout1);
%     Fout2 = Image2Block( testIm, patchsize);
    x_gsize=x;
elseif  strcmp(feature,'PCA-SIFT')
elseif  strcmp(feature,'WV')
    Fout1 = IMG2WV(testIm,7);
    [x y z] = size(Fout1);
    Fout2 = IMG2WV(refIm,7);
    x_gsize = x;
end


%% Step 3. Make dictionary using Fout1
dic = dic2Dto3D(Fout1);
% save('dic.mat','dic');
% save('Fout2.mat','Fout2');
% dic = [];
% Fout2 = [];
% Fout1 = [];
%% Step 4. Candidate finding
if      strcmp(similarity,'OMP')
    cplist = OMP_CP(dic,Fout2, tolerance,x_gsize,C_NO);
    
elseif  strcmp(similarity,'CORR')
    cplist = Corr_CP(dic,Fout2,C_NO);
    
elseif  strcmp(similarity,'SUBS')
    cplist = Subspace_CP(dic,Fout2,x_gsize,C_NO);
end
%% Step 5. BP or grapph-cut

%     if      strcmp(reconst,'BP')
%
%         [FactorsUD,FactorsRL,Variables,Result] = BP (cplist, iter_size,Sigma2);
%         save([I1 '-' I2 '-' feature '-'  similarity '-' reconst '-' int2str(patchsize) '-' ...
%                 int2str(C_NO) '-' datestr(now) '.mat'],'Variables','Result');
%
%     elseif  strcmp(reconst,'GRAPH-CUT')
%     end




%% Step 6. Display
%     NewCP=cplist;
%     NewCP(:,:,:,2:3)=Variables;
%     NewCP(:,:,:,1)=Result;
%     Result_After=disp_genral(refIm,testIm,NewCP,patchsize);


%     Result_After = medfilt2(rgb2gray(Result_After),[2 2]);
%     subplot(2,2,4);imshow(Result_After,[]);title('Result After');

end