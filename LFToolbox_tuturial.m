%% 
% Tuturial LightField toolbox 
% This script must run in structed folder like the one in the LFToolbox.pdf
clear all;
% Build a white image dataset
LFUtilProcessWhiteImages;
%% Decode the sample light fields
LFUtilDecodeLytroFolder('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária');
%% Same as the previous, but with color corretion enabled (Optional)
DecodeOptions.OptionalTasks = 'ColourCorrect';
LFUtilDecodeLytroFolder('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples', [], DecodeOptions);
%% Visualizing the results with a shifting perspective
load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Imagem1/70cm__Decoded.mat');
LFDispMousePan(LF);

%% Getting the train parameters
load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Train/70cm__Decoded.mat');
[top_image, bottom_image, center_image, right_image, left_image] = getApertures(LF);  

[t_gray_top, t_gray_bottom, t_gray_center, t_gray_right, t_gray_left] = RgbToGray(top_image, bottom_image, center_image, right_image, left_image);
[t_diff_top_bottom, t_diff_right_left, t_sum_im] = diffImages(t_gray_top, t_gray_bottom, t_gray_center, t_gray_right, t_gray_left);

trained_mean = mean2(t_sum_im);
trained_std = std2(t_sum_im);

figure;
imshow(t_sum_im);
title('Sum of the Diffs');

%% Main
load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Imagem1/90cm__Decoded.mat');
[top_image, bottom_image, center_image, right_image, left_image] = getApertures(LF);  
% Plot RGB Images
%     plotApertures(top_image, bottom_image, center_image, right_image, left_image);
% RGB to Gray 

[gray_top, gray_bottom, gray_center, gray_right, gray_left] = RgbToGray(top_image, bottom_image, center_image, right_image, left_image);
plotApertures(gray_top, gray_bottom, gray_center, gray_right, gray_left);

%% Threshold images
thresh_level = 90;
th_gray_top = imThresh(gray_top, thresh_level);
th_gray_bottom = imThresh(gray_bottom, thresh_level);
th_gray_center = imThresh(gray_center, thresh_level);
th_gray_right = imThresh(gray_right, thresh_level);
th_gray_left = imThresh(gray_left, thresh_level);
figure;
% imshowpair(gray_top,th_gray_top, 'montage');
imshow(uint8(th_gray_top));
%% Plot the diffs
[diff_top_bottom, diff_right_left, sum_im] = diffImages(gray_top, gray_bottom, gray_center, gray_right, gray_left);
% plotDiffDst(gray_top, diff_top_bottom, gray_bottom, gray_right, diff_right_left, gray_left);
figure;
subplot(1,3,1);
imshow(diff_top_bottom);
title('Diff Top-Bottom');
subplot(1,3,2);
imshow(diff_right_left);
title('Diff Right-Left');
subplot(1,3,3);
imshow(sum_im);
title('Sum of the Diffs');
% [res, mean_std_crack_block, mean_std_no_crack_block] = block_detect( sum_im, 70, 3, 0);
[ res, mean_std_crack_block, mean_mean_crack_block, mean_std_no_crack_block, mean_mean_no_crack_block ] = block_detectV2( sum_im, 40, trained_mean, 1);
figure;
imshowpair(gray_center,res, 'montage');
title('Block Detection res');
%% Plot the diffs(threshold images)
[th_diff_top_bottom, th_diff_right_left, th_sum_im] = diffImages(th_gray_top, th_gray_bottom, th_gray_center, th_gray_right, th_gray_left);
 plotDiffDst(th_gray_top, th_diff_top_bottom, th_gray_bottom, th_gray_right, th_diff_right_left, th_gray_left);
[th_res, th_mean_std_crack_block, th_mean_std_no_crack_block] = block_detect( th_sum_im, 40, 1, 0);
figure;
imshowpair(th_gray_center,th_res, 'montage');
title('Block Detection res');
%% Simple LBP
simple_LBP_features = simple_LBP(LF);
figure;
hist(simple_LBP_features);
%% New LBP
total_LBP_features = LF_LBP(LF,8);
figure;
hist(total_LBP_features);
%% Testing Smooth Anidiff
img = imread('Crack001.png');
img_smooth = SmoothANIDIFF(img,4,60,0.25,2);
figure;
subplot(1,2,1);
imshow(img);
title('Normal image');
subplot(1,2,2);
imshow(img_smooth);
title('Smooth image');

