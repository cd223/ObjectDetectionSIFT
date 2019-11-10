function [result] = doesIntersect(boundingBox1,boundingBox2)
% This function checks if bounding box 1 intersects with bounding box 2


minX = boundingBox1(1);
minY = boundingBox1(2);
maxX = minX + boundingBox1(3);
maxY = minY + boundingBox1(4);

boundingBox2Points = zeros(4,2);
boundingBox2Points(1,:) = boundingBox2(1:2);
boundingBox2Points(2,:) = boundingBox2(1:2) + [boundingBox2(3), 0];
boundingBox2Points(3,:) = boundingBox2(1:2) + [0, boundingBox2(4)];
boundingBox2Points(4,:) = boundingBox2(1:2) + boundingBox2(3:4);

result = false;
for i = 1 : 4
    % Check if each point of bounding box 2 intersects with bounding box 1
    if minX <= boundingBox2Points(i, 1) && boundingBox2Points(i, 1) <= maxX && minY <= boundingBox2Points(i, 2) && boundingBox2Points(i, 2) <= maxY
        result = true;
    end
end

end

