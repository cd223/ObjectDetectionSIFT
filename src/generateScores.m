function [scores] = generateScores(trainImageFeatures, testImageFeatures, numTrainImages)
% This function take the test image and training image features and returns
% the matches that were better than the threshold and had ratio of more
% than 0.8 to second best match

trainFeatureCounter = 0;

for i = 1 : numTrainImages
    for j = 1 : length(trainImageFeatures{i})
        trainFeatureCounter = trainFeatureCounter + 1;
        scores(trainFeatureCounter).trainImageNumber = i;
        scores(trainFeatureCounter).trainFeatureNumber = j;
        scores(trainFeatureCounter).bestSSD = inf;
        for k = 1 : length(testImageFeatures)
            if isfield(trainImageFeatures{i}, 'descriptor') ~= 0 && isfield(testImageFeatures, 'descriptor') ~= 0
                % Calcualte the SSD between each test feature and each
                % training feature
                difference = trainImageFeatures{i}(j).descriptor - testImageFeatures(k).descriptor;
                SSD = sum(difference(:).^2);
                
                % If new lowest SSD is fouind then store it
                if SSD < scores(trainFeatureCounter).bestSSD
                    % Bump previous best SSD into second best SSD slot
                    if isfield(scores(trainFeatureCounter), 'bestTestFeatureNumber') == 0
                        scores(trainFeatureCounter).secondTestFeatureNumber = k;
                        scores(trainFeatureCounter).secondBestSSD = SSD;
                    else
                        scores(trainFeatureCounter).secondTestFeatureNumber = scores(trainFeatureCounter).bestTestFeatureNumber;
                        scores(trainFeatureCounter).secondBestSSD = scores(trainFeatureCounter).bestSSD;
                    end
                    scores(trainFeatureCounter).bestTestFeatureNumber = k;
                    scores(trainFeatureCounter).bestSSD = SSD;
                elseif SSD < scores(trainFeatureCounter).secondBestSSD
                    scores(trainFeatureCounter).secondTestFeatureNumber = k;
                    scores(trainFeatureCounter).secondBestSSD = SSD;
                end
            end
        end
    end
end

end

