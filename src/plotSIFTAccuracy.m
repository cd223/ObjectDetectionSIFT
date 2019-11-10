% This script plots the accuracy values for differing starting sigma and
% sigma factor values

clear;
rootTwo=sqrt(2);
startingSigma = [0.2, 0.4, 0.8, 1.2, 0.2, 0.4, 0.8, 1.2, 0.2, 0.4, 0.8, 1.2];
sigmaFactor = [rootTwo, rootTwo, rootTwo, rootTwo, 2, 2, 2, 2, 2.5, 2.5, 2.5, 2.5];
accuracy = [0,0,0,0,0.125,0.083333333,0,0,0.133333333,0.141666667,0.008333333,0];
accuracy = accuracy .* 100;

xq = linspace(min(startingSigma), max (startingSigma));
yq = linspace(min(sigmaFactor), max (sigmaFactor));
[X,Y] = meshgrid(xq,yq);
Z = griddata(startingSigma,sigmaFactor,accuracy, X, Y, 'cubic');
figure;
surf(X,Y,Z);
grid on;
title('Plot of Initial \sigma and \sigma Factor against Accuracy %')
set(gca,'FontSize',36)
xlabel('Starting \sigma')
ylabel('\sigma Factor')
zlabel('Accuracy %')