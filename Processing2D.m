function [ p_final_im ] = Processing2D( im, sat_im )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

H = fspecial('sobel');
%Apply a sobel filter that emphasizes horizontal edges
h_sobel_im = imfilter(im,H,'replicate');
sat_h_sobel_im = imfilter(sat_im,H,'replicate');

%Apply a sobel filter that emphasizes vertical edges
final_sobel_im = imfilter(h_sobel_im,H','replicate');
sat_final_sobel_im = imfilter(sat_h_sobel_im,H','replicate');

%Median Filter
median_im = medfilt2(sat_final_sobel_im, [3 3]);

canny_im = edge(sat_final_sobel_im,'Canny');



figure;
subplot(3,2,1)
imshow(im);
title('Original Im');
subplot(3,2,2)
imshow(final_sobel_im);
title('Sobel with Original Im');
subplot(3,2,3)
imshow(sat_im);
title('Saturated Im');
subplot(3,2,4)
imshow(sat_final_sobel_im);
title('Sobel with the saturated Im');
subplot(3,2,5)
imshow(median_im);
title('Median filter on the Sobel Im');
subplot(3,2,6)
imshow(canny_im);
title('Canny edge detector(saturated Im)');


p_final_im = pixelAnalysis(median_im,2,0.3,0.99,0.1,1);


end

