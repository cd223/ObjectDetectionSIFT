function [results,accuracy] = SIFTFunction(startI,endI)
%SIFTFUNCTION Summary of this function goes here

startingSigma = [0.2, 0.4, 0.8, 1.2, 0.2, 0.4, 0.8, 1.2, 0.2, 0.4, 0.8, 1.2];
rootTwo = sqrt(2);
sigmaFactor = [rootTwo, rootTwo, rootTwo, rootTwo, 2, 2, 2, 2, 2.5, 2.5, 2.5, 2.5];
SSDThreshold = 0.3;
contrastThreshold = 0.12;
removeMacthedFeatures = true;
testImagePathPart1 = 'dataset\Test\test_';
testImagePathPart2 = '.png';
results = cell(20, 12);
accuracy = cell(20, 12);

for i = startI : endI
    i
    for j = 10 : 10
        j
        testImageNumber = i;
        testImagePath = strcat(testImagePathPart1, num2str(testImageNumber), testImagePathPart2);
        [results{i, j}, accuracy{i, j}] = runSIFT(testImageNumber, testImagePath, SSDThreshold, startingSigma(j), sigmaFactor(j), contrastThreshold, removeMacthedFeatures);
    end
end


end

