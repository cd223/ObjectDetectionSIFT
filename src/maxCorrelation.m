function [correlation, position] = maxCorrelation(image, patch)
% This function computes the maximum correlation between an image and patch

% For RGB do correlation for each colour channel and compute the mean
if size(image, 3) > 1
    correlations(:,:,1) = normxcorr2(patch(:,:,1), image(:,:,1));
    correlations(:,:,2) = normxcorr2(patch(:,:,2), image(:,:,2));
    correlations(:,:,3) = normxcorr2(patch(:,:,3), image(:,:,3));
    correlations = mean(correlations, 3);
else
    correlations = normxcorr2(patch, image);
end

correlation = max(correlations(:));
[ypeak, xpeak] = find(correlations==max(correlations(:)));

% Compute translation from max location in correlation matrix
yOffset = ypeak-size(patch,1);
xOffset = xpeak-size(patch,2);

% If more than one maximum is found then only take the first one
if length(yOffset) > 1
    yOffset = yOffset(1);
end

if length(xOffset) > 1
    xOffset = xOffset(1);
end

position = [xOffset+1, yOffset+1, size(patch,2), size(patch,1)];

end

