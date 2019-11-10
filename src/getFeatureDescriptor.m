function [histogram] = getFeatureDescriptor(input, orientation)
% This function generates 16 historgrams with 8 bins each to represent a
% SIFT feature.

histogram = zeros(16, 8);
windowSize = 16;
gaussianKernel = fspecial('gaussian', windowSize, windowSize / 2);

% Loop through 16 x 16 window calculating gradient angles and magnitudes
for i = 2 : 17
    for j = 2 : 17
        magnitude = ( (input(i + 1, j) - input(i - 1, j))^2 + (input(i, j + 1) - input(i, j - 1))^2 )^0.5;
        angle = calcGradientAngle(input(i - 1 : i + 1, j - 1 : j + 1));
        if angle ~= -1
            % Adjust features orientation based on key point orientation
            angle = mod(angle + (360 - orientation), 360);
            binNumber = idivide(int16(floor(angle)), int16(45)) + 1;
            histogramNumber = floor((i - 2) / 4) * 4 + ceil((j - 1) / 4);
            
            % Trilinear interpolation so that values closer to the centre
            % of the bin are weighted more heavily
            centreOffsetWeight = 1 - (abs(angle - (double(binNumber) * 45) - 22.5)) / 45;
            % Apply gaussian wieghting
            histogram(histogramNumber, binNumber) = histogram(histogramNumber, binNumber) + (magnitude * gaussianKernel(i - 1, j - 1) * centreOffsetWeight);
        end
    end
end

% Normalise histogram
rootOfSquaredSum = sum(sum(power(histogram, 2))) ^ 0.5;
histogram = histogram / rootOfSquaredSum;

% Set values above 0.2 to 0.2
for i = 1 : 16
    for j = 1 : 8
        if histogram(i, j) > 0.2
           histogram(i, j) = 0.2; 
        end
    end
end

% Normalise histogram again
rootOfSquaredSum = sum(sum(power(histogram, 2))) ^ 0.5;
histogram = histogram / rootOfSquaredSum;

end

