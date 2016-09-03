function [ dic ] = dic2Dto3D(im3D)
[x y z]= size(im3D);
dic= reshape(im3D, [x*y z])';
dic = normalizeMatrix(double(dic));
end