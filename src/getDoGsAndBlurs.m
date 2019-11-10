function [DoGs, Blurs] = getDoGsAndBlurs(image, numOctaves, numBlurs, startingSigma, sigmaFactor)
% This function calcualtes the DoGs and Blurs for a given image
Blurs = cell(numOctaves, numBlurs + 1);
DoGs = cell(numOctaves, numBlurs);

for i = 1 : numOctaves
    previousBlurredImage = image;
    Blurs{i, 1} = previousBlurredImage;
    sigma = startingSigma;
    for j = 1 : numBlurs
        gaussianKernel = fspecial('gaussian', 5, sigma);
        % Blur image
        blurredImage = convn(image, gaussianKernel, 'same');
        Blurs{i, j + 1} = blurredImage;
        % Calulate DoG
        DoGs{i, j} = blurredImage - previousBlurredImage;
        previousBlurredImage = blurredImage;
        sigma = sigma * sigmaFactor;
    end
    % Downsample image to next octave
    image = imresize(image, 0.5);
end
end

