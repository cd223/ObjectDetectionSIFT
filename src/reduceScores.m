function [newScores] = reduceScores(scores, SSDThreshold)
% This function gets rid of matches that are below the SSD threshold and matches that
% do not have a ratio of at least 0.8 between the best and second best SSD
newScoreCounter = 1;
newScores = scores(1);
newScores(:) = [];
for i = 1 : length(scores)
    if isfield(scores, 'secondBestSSD') ~= 0 && scores(i).bestSSD ~= Inf
        if scores(i).bestSSD / scores(i).secondBestSSD < 0.8 && scores(i).bestSSD < SSDThreshold
            newScores(newScoreCounter) = scores(i);
            newScoreCounter = newScoreCounter + 1;
        end
    end
end

end