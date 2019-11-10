function [extrema] = getExtrema(DoGs, image, startingSigma, sigmaFactor, contrastThreshold, drawKeyPoints)
% This function get all extrema/key points for a given set of DoGs and gets
% rid of low contrast and edge key points
numOctaves = size(DoGs, 1);

allKeyPoints = image;

counter = 1;

% For each DoG loop through every value and slect extrema from a
% neighbourhood of pixels
for i = 1 : numOctaves
    imageSize = size(DoGs{i, 1});
    for j = 2 : imageSize(1) - 1
        for k = 2 : imageSize(2) - 1
            currentMax = max(max(DoGs{i, 2}(j - 1 : j + 1, k - 1 : k + 1)));
            currentMin = min(min(DoGs{i, 2}(j - 1 : j + 1, k - 1 : k + 1)));
            [minCount, maxCount] = minMaxCount(DoGs{i, 2}(j - 1 : j + 1, k - 1 : k + 1));
            
            % Look for maxima in DoG 2
            if DoGs{i, 2}(j, k) == currentMax && maxCount == 1
                previousMax = max(max(DoGs{i, 1}(j - 1 : j + 1, k - 1 : k + 1)));
                nextMax = max(max(DoGs{i, 3}(j - 1 : j + 1, k - 1 : k + 1)));
                if DoGs{i, 2}(j, k) > previousMax && DoGs{i, 2}(j, k) > nextMax
                    extrema(counter).octaveNumber = i;
                    extrema(counter).y = j;
                    extrema(counter).x = k;
                    extrema(counter).sigma = startingSigma * sigmaFactor;
                    extrema(counter).blurNumber = 2;
                    extrema(counter).DoGNumber = 2;
                    if i == 1
                       allKeyPoints(j, k) = 1; 
                    end
                    counter = counter + 1;
                end
            % Look for minima in DoG 2
            elseif DoGs{i, 2}(j, k) == currentMin && minCount == 1
                previousMin = min(min(DoGs{i, 1}(j - 1 : j + 1, k - 1 : k + 1)));
                nextMin = min(min(DoGs{i, 3}(j - 1 : j + 1, k - 1 : k + 1)));
                if DoGs{i, 2}(j, k) < previousMin && DoGs{i, 2}(j, k) < nextMin
                    extrema(counter).octaveNumber = i;
                    extrema(counter).y = j;
                    extrema(counter).x = k;
                    extrema(counter).sigma = startingSigma * sigmaFactor;
                    extrema(counter).blurNumber = 2;
                    extrema(counter).DoGNumber = 2;
                    if i == 1
                       allKeyPoints(j, k) = 1; 
                    end
                    counter = counter + 1;
                end
            end
            
            currentMax = max(max(DoGs{i, 3}(j - 1 : j + 1, k - 1 : k + 1)));
            currentMin = min(min(DoGs{i, 3}(j - 1 : j + 1, k - 1 : k + 1)));
            [minCount, maxCount] = minMaxCount(DoGs{i, 3}(j - 1 : j + 1, k - 1 : k + 1));
            % Look for maxima in DoG 3
            if DoGs{i, 3}(j, k) == currentMax && maxCount == 1
                previousMax = max(max(DoGs{i, 2}(j - 1 : j + 1, k - 1 : k + 1)));
                nextMax = max(max(DoGs{i, 4}(j - 1 : j + 1, k - 1 : k + 1)));
                if DoGs{i, 3}(j, k) > previousMax && DoGs{i, 3}(j, k) > nextMax
                    extrema(counter).octaveNumber = i;
                    extrema(counter).y = j;
                    extrema(counter).x = k;
                    extrema(counter).sigma = startingSigma * sigmaFactor ^ 3;
                    extrema(counter).blurNumber = 4;
                    extrema(counter).DoGNumber = 3;
                    if i == 1
                       allKeyPoints(j, k) = 1; 
                    end
                    counter = counter + 1;
                end
            % Look for minima in DoG 3
            elseif DoGs{i, 3}(j, k) == currentMin && minCount == 1
                previousMin = min(min(DoGs{i, 2}(j - 1 : j + 1, k - 1 : k + 1)));
                nextMin = min(min(DoGs{i, 4}(j - 1 : j + 1, k - 1 : k + 1)));
                if DoGs{i, 3}(j, k) < previousMin && DoGs{i, 3}(j, k) < nextMin
                    extrema(counter).octaveNumber = i;
                    extrema(counter).y = j;
                    extrema(counter).x = k;
                    extrema(counter).sigma = startingSigma * sigmaFactor ^ 3;
                    extrema(counter).blurNumber = 4;
                    extrema(counter).DoGNumber = 3;
                    if i == 1
                       allKeyPoints(j, k) = 1; 
                    end
                    counter = counter + 1;
                end
            end
        end
    end
end

% Draw key points before refinements
if drawKeyPoints == true
    figure;
    subplot(1,3,1);
    imshow(allKeyPoints);
end

afterCornerKeyPoints = image;

% Reject key points that are edges
counter = 1;
for i = 1 : length(extrema)   
    octaveNumber = extrema(i).octaveNumber;
    y = extrema(i).y;
    x = extrema(i).x;
    DoGNumber = extrema(i).DoGNumber; 
    if isCorner(DoGs{octaveNumber, DoGNumber}(y - 1 : y + 1, x - 1 : x + 1)) == true
        cornerExtrema(counter) = extrema(i);
        if extrema(i).octaveNumber == 1
            afterCornerKeyPoints(y, x) = 1;
        end
        counter = counter + 1;
    end
end

if drawKeyPoints == true
    subplot(1,3,2);
    imshow(afterCornerKeyPoints);
end

% Reject key points that have a low contrast
afterCornerAndThresholdKeyPoints = image;
extrema(:) = [];
counter = 1;
for i = 1 : length(cornerExtrema)
    octaveNumber = cornerExtrema(i).octaveNumber;
    y = cornerExtrema(i).y;
    x = cornerExtrema(i).x;
    DoGNumber = cornerExtrema(i).DoGNumber;
    if abs(DoGs{octaveNumber, DoGNumber}(y, x)) > contrastThreshold
        
        extrema(counter) = cornerExtrema(i);
        if cornerExtrema(i).octaveNumber == 1
            afterCornerAndThresholdKeyPoints(y, x) = 1;
        end
        counter = counter + 1;
    end
end

if drawKeyPoints == true
    subplot(1,3,3);
    imshow(afterCornerAndThresholdKeyPoints);
end

end

