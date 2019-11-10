function [] = drawFeatureMatches(leftImage,rightImage,matches)
% This function draws SIFT matches between the test image features and a
% training image's features

% Calulate how much to translate the training image match coordinates due
% to the images being displayed side by side
paddingYTop = (size(leftImage, 1) - size(rightImage, 1) + 1) / 2;
paddingYBottom = (size(leftImage, 1) - size(rightImage, 1) - 1) / 2;
paddingX = size(leftImage, 2);
for i = 1 : length(matches)
    translatedMatches(i) = matches(i);
    translatedMatches(i).rightImageY = translatedMatches(i).rightImageY + paddingYTop;
    translatedMatches(i).rightImageX = translatedMatches(i).rightImageX + paddingX;
end

% Pad the training image to be the same height as the test image
paddedImage = padarray(rightImage, [paddingYTop 0], 1, 'pre');
paddedImage = padarray(paddedImage, [paddingYBottom 0], 1, 'post');
compositeImage = [leftImage paddedImage];

figure;
imshow(compositeImage);
hold on;
% Draw each match
for i = 1 : length(translatedMatches)
    line([translatedMatches(i).leftImageX; translatedMatches(i).rightImageX], [translatedMatches(i).leftImageY; translatedMatches(i).rightImageY], 'Color', rand(1,3));
end

hold off;

end

