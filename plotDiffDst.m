function [ output_args ] = plotDiffDst( gray_top, diff_gray_top_bottom, gray_bottom, gray_right, diff_gray_right_left, gray_left)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

figure;
subplot(2,3,1);
imshow(gray_top);
title('Top image');
subplot(2,3,2);
imshow(diff_gray_top_bottom);
title('Diff Top image - Bottom Image');
subplot(2,3,3);
imshow(gray_bottom);
title('Bottom image');
subplot(2,3,4);
imshow(gray_right);
title('Right image');
subplot(2,3,5);
imshow(diff_gray_right_left);
title('Diff Right image - Left Image');
subplot(2,3,6);
imshow(gray_left);
title('Left image');

sum_im = diff_gray_right_left + diff_gray_top_bottom;
figure;
imshow(sum_im);
title('sum image');
end

