function [imageList] = getImagePaths(imageDIR)
% This function returns all images in a given directory
images = dir(sprintf('%s/*.png', imageDIR));
imageList = images;
end

