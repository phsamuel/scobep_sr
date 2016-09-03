function [ dic,x_gsize ] = Image2Dic( refIm,patchsize,feature,Search_area )
%% Step 2. Extract Features
if strcmp(feature,'SIFT')
    %patchsize=8;
    gridspacing=1;
    patchsize = 3;
    Fout1=dense_sift(refIm,patchsize,gridspacing);
    [x y z] = size(Fout1);
    patchsize = 3;
    x_gsize = x ;
elseif  strcmp(feature,'BLOCK')

%     Fout1 = Image2Block(refIm,patchsize,id,jd);
    Fout1 = Image2Block_Y(refIm,patchsize,Search_area);
    [x y z] = size(Fout1);
    x_gsize=x;
elseif  strcmp(feature,'PCA-SIFT')
elseif  strcmp(feature,'WV')
    Fout1 = IMG2WV(testIm,7);
    [x y z] = size(Fout1);
    x_gsize = x;
end

%% Step 3. Make dictionary using Fout1
dic = dic2Dto3D(Fout1);
end

