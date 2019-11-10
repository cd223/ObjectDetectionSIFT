function [outputIMG] = resizeImage(inputIMG, gaussianKernel, subsampleRate)
% This function resizes images after applying a gaussiaan blur

% For RGB do correlation for each colour channel seperately
if size(inputIMG, 3) > 1
    image(:, :, 1) = convn(inputIMG(:, :, 1), gaussianKernel, "same");
    image(:, :, 2) = convn(inputIMG(:, :, 2), gaussianKernel, "same");
    image(:, :, 3) = convn(inputIMG(:, :, 3), gaussianKernel, "same");
else
    image = convn(inputIMG, gaussianKernel, "same");
end

% Subsample image
outputIMG = image(1 : 2^(subsampleRate-1) : end, 1 : 2^(subsampleRate-1) : end, :);
end

