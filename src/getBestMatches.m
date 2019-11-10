function [bestMatches] = getBestMatches(sortedResults)
% This function takes the guessed bounding box for each training image
% class and discards any guesses that have bounding boxes that intersect
% with the best guesses

bestMatches = cell(1,5);
bestMatchesCounter = 1;
overlappingMatchesExist = true;

% Loop until only non overlapping bounding box guesses remain
while overlappingMatchesExist == true
    bestMatches(bestMatchesCounter, :) = sortedResults(1, :);
    sortedResults(1, :) = [];
    index = 1;
    maxIndex = size(sortedResults, 1);
    for i = 1 : maxIndex
        % Calcualte if two bounding boxes intersect
        if doesIntersect(bestMatches{bestMatchesCounter, 5}, sortedResults{index, 5}) == true || doesIntersect(sortedResults{index, 5}, bestMatches{bestMatchesCounter, 5}) == true
            sortedResults(index, :) = [];
        else
            index = index + 1;
        end
    end
    bestMatchesCounter = bestMatchesCounter + 1;
    if size(sortedResults, 1) == 0
        overlappingMatchesExist = false;
    end
end

end