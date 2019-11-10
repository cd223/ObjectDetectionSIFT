function [features] = getAllFeatureDescriptors(image, startingSigma, sigmaFactor, contrastThreshold, drawKeyPoints)
% This function gets all the SIFT features for a given image

numBlurs = 4;
numOctaves = 4;

% Generate DoG pyramid and every blurred test image
[DoGs Blurs] = getDoGsAndBlurs(image, numOctaves, numBlurs, startingSigma, sigmaFactor);

% Get extrema from the DoGs
extrema = getExtrema(DoGs, image, startingSigma, sigmaFactor, contrastThreshold, drawKeyPoints);

features = struct();

if isfield(extrema, 'octaveNumber') ~= 0
    numOriginalExtrema = length(extrema);
    newExtremaCounter = 1;
    
    % Get rotation of each key point and create new key points for key
    % points that have more than one dominant rotation
    for i = 1 : numOriginalExtrema
        [rotation, secondRotation] = getRotationOrientation(extrema(i), Blurs{extrema(i).octaveNumber, extrema(i).blurNumber});
        extrema(i).rotation = rotation;
        if secondRotation ~= -1
            extrema(numOriginalExtrema + newExtremaCounter) = extrema(i);
            extrema(numOriginalExtrema + newExtremaCounter).rotation = secondRotation;
            newExtremaCounter = newExtremaCounter + 1;
        end
    end

    featureCounter = 1;
    % Get the feature descriptor for each extrema/key point
    for i = 1 : length(extrema)
        if extrema(i).y - 8 >= 1 && extrema(i).x - 8 >= 1  && extrema(i).y + 9 <= size(Blurs{extrema(i).octaveNumber, extrema(i).blurNumber}, 1) && extrema(i).x + 9 <= size(Blurs{extrema(i).octaveNumber, extrema(i).blurNumber}, 2)
            subSection = Blurs{extrema(i).octaveNumber, extrema(i).blurNumber}(extrema(i).y - 8 : extrema(i).y + 9, extrema(i).x - 8 : extrema(i).x + 9);
            features(featureCounter).descriptor = getFeatureDescriptor(subSection, extrema(i).rotation);
            features(featureCounter).y = extrema(i).y;
            features(featureCounter).x = extrema(i).x;
            features(featureCounter).octaveNumber = extrema(i).octaveNumber;
            features(featureCounter).rotation = extrema(i).rotation;
            featureCounter = featureCounter + 1;
        end
    end
end
end

