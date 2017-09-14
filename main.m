% Getting the train parameters
thresh_level = 40;
%Mac or Windows
%load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Train/100cm__Decoded.mat');
load('C:\Users\david\Desktop\Samples\Images\Cidade Universitária\Estrada1\Train\100cm__Decoded.mat');
[train_central_im, train_sum_im_v, train_sum_im_h, train_sum_im_t] = sumAllApertures( LF , thresh_level, 10,1);
t_central_im  = getCentralAperture( LF );

%% Plot train image
figure;
subplot(1,2,1);
imshow(t_central_im);
title('Train image');

subplot(1,2,2);
imshow(train_sum_im_t);
title('Train image Saturated');

%%
[trained_mean, trained_std] = train_params(train_sum_im_t, thresh_level);  

%% Processing the crack image
thresh_level = 40;
% load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Imagem1/100cm__Decoded.mat');
load('C:\Users\david\Desktop\Samples\Images\Cidade Universitária\Estrada1\Imagem1\100cm__Decoded.mat');
[sat_central_im, sum_im_v, sum_im_h, sum_im_t] = sumAllApertures( LF , thresh_level,9,1);
central_im  = getCentralAperture( LF );
final_im = sum_im_v + sum_im_h;
%% 2D Processing
twoD_processed_im = Processing2D(central_im, sat_central_im);

%% Plot the diff images results
showDiffResults(LF, 40);


%% Plot central image
figure;
subplot(1,2,1);
imshow(squeeze(LF(8,8,:,:,1:3)));
title('Central Image');
subplot(1,2,2);
imshow(sat_central_im);
title('Central Image');
%% Plotting apertures
figure;
subplot(1,3,1);
imshow(sum_im_v);
title('Sum Vertical');
subplot(1,3,2);
imshow(sum_im_h);
title('SUM Horizontal');
subplot(1,3,3);
imshow(final_im);
title('SUM total');
%% Use the sobel operator
H = fspecial('sobel');
%Apply a sobel filter that emphasizes horizontal edges
h_sobel_im = imfilter(sum_im_v,H,'replicate');
%Apply a sobel filter that emphasizes vertical edges
v_sobel_im = imfilter(sum_im_h,H','replicate');
final_sobel_im = h_sobel_im + v_sobel_im;
figure;
subplot(3,2,1)
imshow(sum_im_h);
title('Original sum im h');
subplot(3,2,2)
imshow(v_sobel_im);
title('Sobel vertical');
subplot(3,2,3)
imshow(sum_im_v);
title('Original sum im v');
subplot(3,2,4)
imshow(h_sobel_im);
title('Sobel horizontal');
subplot(3,2,5)
imshow(final_im);
title('Original Final Im');
subplot(3,2,6)
imshow(final_sobel_im);
title('Sobel Final Im');

%% Median 
median_im = medfilt2(final_im, [5 5]);
median_sobel_im = medfilt2(final_sobel_im, [5 5]);

figure;
subplot(2,2,1)
imshow(final_sobel_im);
title('Sobel Im');
subplot(2,2,2);
imshow(median_sobel_im);
title('Median of the Sobel Im');
subplot(2,2,3)
imshow(final_im);
title(' Final Im without Sobel');
subplot(2,2,4);
imshow(median_im);
title('Median Final Im');

%% Histogram
p_final_im_sobel = pixelAnalysis(median_sobel_im,2,0.5,0.99,0.2,1);
p_final_im = pixelAnalysis(median_im,2,0.5,0.99,0.2,1);

figure;
subplot(1,2,1);
imshow(p_final_im);
title('Final Result without Sobel');
subplot(1,2,2);
imshow(p_final_im_sobel);
title('Final Result with sobel and Median');

%% Canny
BW1 = edge(sat_central_im,'Sobel');
figure;
imshow(BW1);

%% Block Detect (alterar a função block_detect para receber a dimensao em pixeis)
num_of_blocks = 40;
trained_mean = mean2(train_sum_im_t);
trained_std = std2(train_sum_im_t);
% Imagem original
[ res1, mean_std_crack_block1, mean_mean_crack_block1, mean_std_no_crack_block1, mean_mean_no_crack_block1 ] = ...
    block_detect( final_im, num_of_blocks, 3, 0.3, 1);

[ res2, mean_std_crack_block2, mean_mean_crack_block2, mean_std_no_crack_block2, mean_mean_no_crack_block2 ] = ...
    block_detectV2( final_im, num_of_blocks, 3, trained_mean, 4, trained_std, 1);

t_smooth_im = imfilter(train_sum_im_t,h,'replicate');
s_trained_mean = mean2(t_smooth_im);
s_trained_std = std2(t_smooth_im);
% Imagem original blured
[ res3, mean_std_crack_block3, mean_mean_crack_block3, mean_std_no_crack_block3, mean_mean_no_crack_block3 ] = ...
    block_detect( smooth_im, num_of_blocks, 3, 0.3, 1);

[ res4, mean_std_crack_block4, mean_mean_crack_block4, mean_std_no_crack_block4, mean_mean_no_crack_block4 ] = ...
    block_detectV2( smooth_im, num_of_blocks, s_trained_mean, 3, 5, trained_std, 1);

figure;
subplot(2,3,1);
imshow(final_im);
title('Original Image');

subplot(2,3,2);
imshow(res1);
title('Block detect V1');

subplot(2,3,3);
imshow(res2);
title('Block detect V2');

subplot(2,3,4);
imshow(smooth_im);
title('Blured Original Image');

subplot(2,3,5);
imshow(res3);
title('Block detect V1');

subplot(2,3,6);
imshow(res4);
title('Block detect V2');


