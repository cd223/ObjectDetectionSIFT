function [rotation, secondRotation] = getRotationOrientation(extrema, blurredImage)
% This function get the dominent and second dominent orientation for a key
% point

rotation = -1;
secondRotation = -1;
windowSize = 15;
halfWindowSize = (windowSize + 1) / 2;

% Check key point is not too close to the edge of the image to look at a
% neighbourhood of gradients
if extrema.y - halfWindowSize >= 1 && extrema.x - halfWindowSize >= 1 && extrema.y + halfWindowSize <= size(blurredImage, 1) && extrema.x + halfWindowSize <= size(blurredImage, 2)
    
    % Take neighbourhood subsection
    subSection = blurredImage(extrema.y - halfWindowSize : extrema.y + halfWindowSize, extrema.x - halfWindowSize : extrema.x + halfWindowSize);
    histogram = zeros(36,1);
    gaussianKernel = fspecial('gaussian', windowSize, extrema.sigma * 1.5);
    
    % Magnitude calculation and Orientatioin calculation
    for i = 2 : windowSize + 1
        for j = 2 : windowSize + 1
            magnitude = ( (subSection(i + 1, j) - subSection(i - 1, j))^2 + (subSection(i, j + 1) - subSection(i, j - 1))^2 )^0.5;
            angle = calcGradientAngle(subSection(i - 1 : i + 1, j - 1 : j + 1));
            if angle ~= -1
                binNumber = idivide(int16(floor(angle)), int16(10)) + 1;
                % Add each rotation to the historgram with gaussain
                % weighting
                histogram(binNumber) = histogram(binNumber) + (magnitude * gaussianKernel(i - 1, j - 1)); 
            end
        end
    end
    % Find max histogram bin
    maximum = max(histogram);
    for i = 1 : 36
        if maximum == histogram(i)
            rotation = (i - 1) * 10 + 5;
            % If the second maximum bin is within 80% of the maximum bin
            % then calcualte the secondary rotation
        elseif 0.8 * maximum < histogram(i)
            secondRotation = (i - 1) * 10 + 5;
        end
    end
end

end

