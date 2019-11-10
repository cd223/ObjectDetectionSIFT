function [angle] = calcGradientAngle(input)
% This function calcualtes the angle betwewen the poitive x axis and the
% graident of an image patch

fy = input(3, 2) - input(1, 2);
fx = input(2, 3) - input(2, 1);

% Check which quadrant the gradient vector lies in and adjust the value
% produces from atan so that the angles re in the range 0-360 degrees
if fx > 0 && fy > 0
    angle = 90 - radtodeg(atan( fx/fy ));
elseif fx > 0 && fy < 0
    angle = 270 + abs(radtodeg(atan( fx/fy )));
elseif fx < 0 && fy > 0
    angle = abs(radtodeg(atan( fx/fy ))) + 90;
elseif fx < 0 && fy < 0
    angle = 270 - radtodeg(atan( fx/fy ));
end

% Tan is not defined well at 90, 180, 270 and 360 degress so this is
% calculated manually
if fx == 0 && fy > 0
    angle = 90;
elseif fx == 0 && fy < 0
    angle = 270;
elseif fy == 0 && fx > 0
    angle = 0;
elseif fy == 0 && fx < 0
    angle = 180;
end

% If the gradient is constant across the patch then the angle is set to -1
% so that this feature can be discarded
if fx == 0 && fy == 0
    angle = -1;
end

if angle == 360
    angle = 0;
end

end

