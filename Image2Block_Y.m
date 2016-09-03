function [ blockOutIm ] = Image2Block_Y( testIm,gapsize,Search_area)
[x y z] = size(testIm);
    for i=1+gapsize+Search_area : x-gapsize-Search_area
        for j=1+gapsize+Search_area:y-gapsize-Search_area
            blockIm = testIm(i-gapsize:i+gapsize,j-gapsize:j+gapsize,:);
            temp = blockIm(:);
            blockOutIm (i-gapsize-Search_area,j-gapsize-Search_area,:) = temp(:)';
        end
    end
end

