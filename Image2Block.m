function [ blockOutIm ] = Image2Block( testIm,gapsize,k_s,k_e,l_s,l_e)
[x y z] = size(testIm);
countI = 1;

    for i=k_s : k_e
    countJ = 1;    
        for j=l_s:l_e
            blockIm = testIm(i-gapsize:i+gapsize,j-gapsize:j+gapsize,:);
            temp = blockIm(:);
            blockOutIm (countI,countJ,:) = temp(:)';
%        toc   
 countJ = countJ +1;
        end
 countI = countI +1;
%   disp (countI)
    end
end


