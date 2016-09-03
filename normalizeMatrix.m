function imgvectors = normalizeMatrix(imgvectors)
    n = size(imgvectors,2);
    imgvectors = full(imgvectors*sparse([1:n],[1:n],1./sqrt(sum(imgvectors.^2))));
end
