function [] = runIntensityMatching(testImageNumber)
% This function runs the whole intensity based matching task

numSizes = 5;
numRotations = 2;
greyScale = true;
rotationStep = 360 / numRotations;

% Create test image path
testImagePathPart1 = 'dataset\Test\test_';
testImagePathPart2 = '.png';
testImagePath = strcat(testImagePathPart1, num2str(testImageNumber), testImagePathPart2);

% Read in training images
trainImageDIR = 'dataset\Training\png\';
listTrainingImages = getImagePaths(trainImageDIR);
numTrainImages = length(listTrainingImages);

% Generate all templates
templateIMGs = cell(numRotations, numSizes, numTrainImages);
templateIMGs = generateTemplates(numTrainImages, trainImageDIR, listTrainingImages, numRotations, rotationStep, numSizes, greyScale);

testImage = im2double(imread(testImagePath));
if greyScale == true
    testImage = rgb2gray(testImage);
end

% Get maximum correlation between each training image class and the test
% image
maxSet = cell(numTrainImages, 5);
maxSet = getAllMaxCorrelations(numRotations, rotationStep, numSizes, numTrainImages, listTrainingImages, templateIMGs, testImage);

sortedResults = sortrows(maxSet, 4, 'descend');
bestMatches = cell(1,5);
bestMatches = getBestMatches(sortedResults);

% Draw matches
drawIntensityMatches(bestMatches,testImage);

end

