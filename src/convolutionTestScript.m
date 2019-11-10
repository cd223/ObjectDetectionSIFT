% This script shows that our covolution function produces the same results
% as conv2 by calculating the difference between the output from our
% convolution function and conv2 with a variety of images and kernels

image = double(int32(rand(3,3) * 100));
kernel = [-1,0,1;-2,0,2;-1,0,1];

convolution(image, kernel, 0, false) - conv2(image, kernel)

image = double(int32(rand(4,4) * 100));
convolution(image, kernel, 0, false) - conv2(image, kernel)

kernel = [1,2,3,4;5,6,7,8;9,10,11,12;13,14,15,16];
convolution(image, kernel, 0, false) - conv2(image, kernel)

image = double(int32(rand(3,3) * 100));
convolution(image, kernel, 0, false) - conv2(image, kernel)


% This shows convolution with the output being the same size as the input
image = double(int32(rand(3,3) * 100));
kernel = [1,2,3;4,5,6;7,8,9];

convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

image = double(int32(rand(4,4) * 100));
convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

kernel = [1,2,3,4;5,6,7,8;9,10,11,12;13,14,15,16];
convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

image = double(int32(rand(3,3) * 100));
convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

image = double(int32(rand(7,7) * 100));
kernel = [1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25];

convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

image = double(int32(rand(6,6) * 100));
convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

kernel = [1,2,3,4,5,6;7,8,9,10,11,12;13,14,15,16,17,18;19,20,21,22,23,24;25,26,27,28,29,30;31,32,33,34,35,36];
convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')

image = double(int32(rand(7,7) * 100));
convolution(image, kernel, 0, true) - conv2(image, kernel, 'same')