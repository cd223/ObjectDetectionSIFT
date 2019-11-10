function [matches] = generateMatches(testImageFeatures, trainImageFeatures, scores, trainImageNumber)
% This function generates the coordinates of the SIFT test and training features
% that matched

counter = 1;
for i = 1 : length(scores)
    if scores(i).trainImageNumber == trainImageNumber
        yTest = testImageFeatures(scores(i).bestTestFeatureNumber).y;
        xTest = testImageFeatures(scores(i).bestTestFeatureNumber).x;
        
        % Apply scaling due to differences in octaves
        octaveTest = testImageFeatures(scores(i).bestTestFeatureNumber).octaveNumber;
        factorTest = 2^(octaveTest - 1);
        yTest = yTest * factorTest;
        xTest = xTest * factorTest;
        
        % Apply scaling due to differences in octaves
        yTrain = trainImageFeatures{scores(i).trainImageNumber}(scores(i).trainFeatureNumber).y;
        xTrain = trainImageFeatures{scores(i).trainImageNumber}(scores(i).trainFeatureNumber).x;
        octaveTrain = trainImageFeatures{scores(i).trainImageNumber}(scores(i).trainFeatureNumber).octaveNumber;
        factorTrain = 2^(octaveTrain - 1);
        yTrain = yTrain * factorTrain;
        xTrain = xTrain * factorTrain;
        
        matches(counter).leftImageY = yTest;
        matches(counter).leftImageX = xTest;
        matches(counter).rightImageY = yTrain;
        matches(counter).rightImageX = xTrain;
        counter = counter + 1;
    end
end
end

