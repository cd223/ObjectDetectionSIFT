function [resultIMG] = convolution(image, kernel, pad, sameSize)

% This function performs the 2D correlation between a kernal and image.

kernelSize = size(kernel);

% Calculate how much to pad the image
padSize = kernelSize - 1;
resultDepth = size(image, 3);

% Rotate the kernel 180 degrees
kernel = rot90(rot90(kernel));
kernel = repmat(kernel, 1, 1, resultDepth);

origHeight = size(image, 1);
origWidth = size(image, 2);

resultHeight = origHeight + padSize(1);
resultWidth = origWidth + padSize(2);

% Pad the image
image = padarray(image, padSize, pad, 'both');
resultIMG = zeros(resultHeight, resultWidth, resultDepth);

% Loop through every pixel and compute thesum of the elementwise multiplication
% between surrounding pixels and the kernel
for i = 1: resultHeight
    for j = 1: resultWidth
        submatrix = image(i: i + kernelSize(1) - 1, j: j + kernelSize(2) - 1, :);
        calculatedmatrix = submatrix .* kernel;
        resultIMG(i, j, :) = sum(sum(calculatedmatrix, 1), 2);
    end
end

% Crop image if the same size parameter is true
if sameSize == true
    startHeight = 1 + idivide(int32(kernelSize(1)), 2);
    startWidth = 1 + idivide(int32(kernelSize(2)), 2);
    endHeight = startHeight + origHeight - 1;
    endWidth = startWidth + origWidth - 1;
    resultIMG = resultIMG(startHeight : endHeight, startWidth : endWidth, :);
end

end