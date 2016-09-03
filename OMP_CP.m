% [ cplist ] = find_CP( dic,testIm, tolerance)
%
% This function reads dictionary and test image SIFT keypoints and returns the list
% included five condidate points
% for each SIFT keypoint.
%   Input parameters:
%     imageFile: the file name for the image.
%
%   Returned:
%     image: the image array in double format
%     descriptors: a K-by-128 matrix, where each row gives an invariant
%         descriptor for one of the K keypoints.  The descriptor is a vector
%         of 128 values normalized to unit length.
%     locs: K-by-4 matrix, in which each row has the 4 values for a
%         keypoint location (row, column, scale, orientation).  The
%         orientation is in the range [-PI, PI] radians.
%
% Credits: Thanks for initial version of this program to D. Alvaro and
%          J.J. Guerrero, Universidad de Zaragoza (modified by D. Lowe)

function [ cplist ] = OMP_CP( dic,testIm, tolerance,x,C_NO,t)


isNonnegative = false;
if(~exist('tolerance','var'))
    tolerance = 5e-2;
end;

n = size(dic,2);

maxIteration = 5000;
isNonnegative = false;
lambda = 1e-2;
tolerance = 0.5;
sparsityRatio=0.1;
stoppingCriterion = -1;

k=ceil(sparsityRatio*n);

 sparseSupport = randperm(n);
            x0=zeros(n,1);
            x0(sparseSupport(1:k))=randn(1,k);
            x0 = x0 / norm(x0);
            if isNonnegative
                x0 = abs(x0);
            end
            
            
for idr=1:size(testIm,1)
    for idc=1:size(testIm,2)
       
            y = testIm(idr,idc,:);
            y = reshape(y,[1 size(y,3)]);
            y = y';
            x1 = SolveOMP(dic, y, ...
                 'maxIteration', maxIteration, ...
                        'isNonnegative', isNonnegative, ...
                        'lambda', lambda, ...
                        'stoppingcriterion', stoppingCriterion, ...
                        'groundtruth', x0, ...
                        'tolerance', tolerance);
                    toc
            cplist(idr,idc,:,:) = CP_residual(dic, x1, y,x,C_NO);
            toc
     end
%     disp([idr idc]);dic, x1.x_hat, y,x,C_NO
end
end

