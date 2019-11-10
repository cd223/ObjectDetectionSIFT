function [maxSet] = getAllMaxCorrelations(numRotations, rotationStep, numSizes, numTrainImages, listTrainingImages, templateIMGs, testImage)
% This function returns the maximum correlation between each training image
% and the test image along with additional information


maxSet = cell(numTrainImages, 5);
for i = 1 : numTrainImages
    maxSet{i, 4} = -inf;
end

% Calcualte correlation for each template and store the maximum for each
% training class
for i = 1 : numRotations
    for j = 2 : numSizes
        for k = 1 : numTrainImages
            [correlation, position] = maxCorrelation(testImage, templateIMGs{i, j, k});
            if correlation > maxSet{k, 4}
                maxSet{k, 1} = (i - 1) * rotationStep;
                maxSet{k, 2} = listTrainingImages(k).name;
                maxSet{k, 3} = j;
                maxSet{k, 4} = correlation;
                maxSet{k, 5} = position;
            end
        end
    end
end
end

