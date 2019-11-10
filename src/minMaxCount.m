function [minCount, maxCount] = minMaxCount(input)
% This function calcualtes the number of times that maxmimum and minimumm
% values occur in a matrix;
minCount = 0;
maxCount = 0;
maximum = max(input(:));
minimum = min(input(:));
inputSize = size(input, 1) * size(input, 2);
for i = 1 : inputSize
    if input(i) == maximum
        maxCount = maxCount + 1;
    end
    if input(i) == minimum
        minCount = minCount + 1;
    end
end
end

