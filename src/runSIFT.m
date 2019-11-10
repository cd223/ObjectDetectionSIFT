function [results, accuracy] = runSIFT(testImageNumber, testImagePath, SSDThreshold, startingSigma, sigmaFactor, contrastThreshold, removeMacthedFeatures)
% This function runs the whole SIFT algorithm

trainImagesRGB = cell(50, 1);
trainImagesGray = cell(50, 1);
trainImageFeatures = cell(50, 1);
drawKeyPoints = false;
trainImageDIR = 'dataset\Training\png\';
listTrainImages = getImagePaths(trainImageDIR);
numTrainImages = length(listTrainImages);

% Load in all the training images and generate their SIFT features
for i = 1 : numTrainImages
    trainImagesRGB{i} = im2double(imread(strcat(trainImageDIR, listTrainImages(i).name)));
    trainImagesGray{i} = rgb2gray(trainImagesRGB{i});
    %trainImageFeatures{i} = getAllFeatureDescriptors(trainImagesGray{i}, startingSigma, sigmaFactor, contrastThreshold, drawKeyPoints);
end

% Load the correct answers to the test images
load('answers.mat');

% Load training image features for speed
load('train_features.mat');
%save('train_features', 'trainImageFeatures');

% Read in the test image
testImageRGB = im2double(imread(testImagePath));
testImageGray = rgb2gray(testImageRGB);
testImageFeatures = getAllFeatureDescriptors(testImageGray, startingSigma, sigmaFactor, contrastThreshold, false);

scores = generateScores(trainImageFeatures, testImageFeatures, numTrainImages);
if length(scores) > 1
    scores = reduceScores(scores, SSDThreshold);
end

results = generateResults(scores, trainImageFeatures, removeMacthedFeatures);

% Commented out function calls for displaying results

% drawSIFTDescriptors(trainImageFeatures{46}, trainImagesRGB{46}, true);
% drawSIFTDescriptors(testImageFeatures, testImageRGB, true);
%matches = generateMatches(testImageFeatures, trainImageFeatures, scores, 24);
%drawFeatureMatches(testImageRGB, trainImagesRGB{24}, matches);

% Calculate accuracy of SIFT matching
accuracy = 0;
for i = 1 : length(results)
    if ismember(results(i), answers(testImageNumber, :)) == 1
        accuracy = accuracy + 1;
    end
end

end

