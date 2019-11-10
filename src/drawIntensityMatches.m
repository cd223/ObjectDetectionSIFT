function [] = drawIntensityMatches(bestMatches,testImage)
% Draws boxes around intensity based matches

figure;
imshow(testImage);
hold on;
for i = 1 : size(bestMatches, 1)
    
    % y x are the coordinates of the bottom left corner of the box
    y = bestMatches{i, 5}(2);
    x = bestMatches{i, 5}(1);
    rotation = bestMatches{i, 1};
    featureSize = bestMatches{i, 5}(3);
    cornerCoordinates = [x;y];
    
    % Calculate coordinates for top right of box
    endCornerCoordinates = cornerCoordinates + featureSize;
    translation = featureSize / 2 + cornerCoordinates;
    
    % Translate all coordinates so that the box is centred on the origin
    cornerCoordinates = cornerCoordinates - translation;
    endCornerCoordinates = endCornerCoordinates - translation;
    allCornerCoordinates = [cornerCoordinates(1), endCornerCoordinates(1), endCornerCoordinates(1), cornerCoordinates(1), cornerCoordinates(1); cornerCoordinates(2), cornerCoordinates(2), endCornerCoordinates(2), endCornerCoordinates(2), cornerCoordinates(2)];
    rotationMatrix = [cos(deg2rad(rotation)), -sin(deg2rad(rotation)) ; sin(deg2rad(rotation)), cos(deg2rad(rotation))];
    
    % Rotate box using rotation matrix
    rotatedCoordinates = rotationMatrix * allCornerCoordinates;
    
    % Translate box back to orginal position
    translatedBackCoordinates = rotatedCoordinates + translation;
    
    % Draw class names
    text(bestMatches{i, 5}(1), bestMatches{i, 5}(2)-30, bestMatches(i, 2), 'Color', 'red','FontSize',14);
    
    % Plot box
    plot(translatedBackCoordinates(1,:), translatedBackCoordinates(2,:), 'g','LineWidth', 2);
end
hold off;
end

