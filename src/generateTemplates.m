function [templateIMGs] = generateTemplates(numTrainImages, trainImageDIR, listTrainImages, numRotations, rotationStep, numSizes, greyScale)
% This function generates all the rotated and scaled template images for
% intensity based matching.

% Generate gaussian kernels for down sampling
gaussianKernels = cell(numSizes - 1, 1);
for i = 1 : numSizes - 1
    gaussianKernels{i} = fspecial('gaussian', 5, 2^(i-1));
end

for i = 1 : numTrainImages
    % Read in training image
    inputIMG = im2double(imread(strcat(trainImageDIR, listTrainImages(i).name)));
    
    if greyScale == true
        inputIMG = mean(inputIMG, 3);
    end
    
    % Rotate training image
    for j = 1 : numRotations
        templateIMGs{j, 1, i} = imrotate(inputIMG, (j - 1) * rotationStep);
    end
    
    % Scale each rotated training image n times
    for j = 1 : numRotations
        for k = 2 : numSizes
            % Apply gaussian blur and downsample
            templateIMGs{j, k, i} = resizeImage(templateIMGs{j, k - 1, i}, gaussianKernels{k - 1}, 2);
        end
    end
end
end

