function [] = drawSIFTDescriptors(features, image, drawRotation)
% This function draws rotated and scaled boxes around SIFT features

figure;
imshow(image);
hold on;
for i = 1 : length(features)
    
        centreY = features(i).y;
        centreX = features(i).x;
        octave = features(i).octaveNumber;
        rotation = features(i).rotation;
        featureSize = power(2, 3 + octave);
        
        % Apply any translation needed due to displaying the features on a
        % full sized image
        centreY = centreY * power(2, octave - 1);
        centreX = centreX * power(2, octave - 1);
        centreCoordinates = [centreX;centreY];
        
        % Move from centre of box to corner
        cornerCoordinates = centreCoordinates - (featureSize / 2 - 1);
        
        if drawRotation == false
            rectangle('Position', [cornerCoordinates(1) cornerCoordinates(2) featureSize featureSize], 'EdgeColor', 'g');
        else
            % Calculate coordinates of the top right corner of the box
            endCornerCoordinates = cornerCoordinates + featureSize;
            translation = featureSize / 2 + cornerCoordinates;
            % Translate box so that the centre of the box is at the origin
            cornerCoordinates = cornerCoordinates - translation;
            endCornerCoordinates = endCornerCoordinates - translation;
            allCornerCoordinates = [cornerCoordinates(1), endCornerCoordinates(1), endCornerCoordinates(1), cornerCoordinates(1), cornerCoordinates(1); cornerCoordinates(2), cornerCoordinates(2), endCornerCoordinates(2), endCornerCoordinates(2), cornerCoordinates(2)];
            rotationMatrix = [cos(deg2rad(rotation)), -sin(deg2rad(rotation)) ; sin(deg2rad(rotation)), cos(deg2rad(rotation))];
            % Apply rotation to the box coordinates
            rotatedCoordinates = rotationMatrix * allCornerCoordinates;
            % Translate box back to original position
            translatedBackCoordinates = rotatedCoordinates + translation;
            % Plot box
            plot(translatedBackCoordinates(1,:), translatedBackCoordinates(2,:), 'g', 'LineWidth', 2);
        end
end
hold off;
end