function [finalResult] = generateResults(scores, trainImageFeatures, removeMacthedFeatures)
% This function generates the guesses for SIFT object recognition

finalResult = zeros(6, 1);

% Loop 6 times for each icon in the test image
for i = 1 : 6
    % Check that scores is not empty
    if isfield(scores, 'secondBestSSD') ~= 0 && length(scores) > 1
        sumSSDs = zeros(50, 3);
        % Sum the SSDs for all the scores
        for j = 1 : length(scores)
            sumSSDs(scores(j).trainImageNumber, 1) = sumSSDs(scores(j).trainImageNumber, 1) + scores(j).bestSSD;
            sumSSDs(scores(j).trainImageNumber, 2) = length(trainImageFeatures{scores(j).trainImageNumber});
            sumSSDs(scores(j).trainImageNumber, 3) = sumSSDs(scores(j).trainImageNumber, 3) + 1;
        end
        
        % Calculate best result
        results = zeros(50, 4);
        results(:, 1) = (1:50);
        results(:, 2) = sumSSDs(:, 1) ./ sumSSDs(:, 2);
        results(:, 3) = sumSSDs(:, 1) ./ sumSSDs(:, 3);
        results(:, 4) = sumSSDs(:, 2) ./ sumSSDs(:, 3);
        sortedResults = sortrows(results, 3);
        finalResult(i) = sortedResults(1,1);
        
        if removeMacthedFeatures == true
            counter = 1;
            discardFeatures = zeros(1,1);
            % If a test feature was matched by best training image then remember it
            for j = 1 : length(scores)
                if scores(j).trainImageNumber == finalResult(i)
                    discardFeatures(counter) = scores(j).bestTestFeatureNumber;
                    counter = counter + 1;
                end
            end
            counter = 1;
            newScores = scores(1);
            newScores(:)= [];
            % Remove macthes involving test features that matched to the
            % best training image guess in this iteration
            for j = 1 : length(scores)
                if ismember(scores(j).bestTestFeatureNumber, discardFeatures) == false
                    newScores(counter) = scores(j);
                    counter = counter + 1;
                end
            end
            scores = newScores;
        end
    
    end
end
end

