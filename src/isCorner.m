function [corner] = isCorner(patch)
% This function detect if a pixel is on a corner or an edge
r = 10;

% Calculate Hessian matrix
DXX = patch(2,3)+patch(2,1)-2*patch(2,2);
DYY = patch(3,2)+patch(1,2)-2*patch(2,2);
DXY = (patch(1,1)+patch(3,3)-patch(1,3)-patch(3,1)) / 4;
trace = DXX+DYY;
determinant = DXX*DYY-DXY*DXY;
curvature = trace*trace/determinant;

% Check if the pixel is on a corner
if curvature > (r+1)^2/r || determinant < 0
    corner = false;
else
    corner = true;
end

end

