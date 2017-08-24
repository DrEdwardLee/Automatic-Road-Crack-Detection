% Getting the train parameters
thresh_level = 40;
%Mac or Windows
% load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Train/100cm__Decoded.mat');
load('C:\Users\david\Desktop\Samples\Images\Cidade Universitária\Estrada1\Train\100cm__Decoded.mat');
[train_central_im, train_sum_im_v, train_sum_im_h, train_sum_im_t] = sumAllApertures( LF , thresh_level);
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
trained_mean = mean2(train_sum_im_t);
trained_std = std2(train_sum_im_t);

%%
[trained_mean, trained_std] = train_params(train_sum_im_t, thresh_level);  

%% Processing the crack image
% load('/Users/davidluisdiasfernandes/Documents/MATLAB/Samples/Cidade Universitária/Estrada1/Imagem2/100cm__Decoded.mat');
load('C:\Users\david\Desktop\Samples\Images\Cidade Universitária\Estrada1\Imagem2\100cm__Decoded.mat');
[sat_central_im, sum_im_v, sum_im_h, sum_im_t] = sumAllApertures( LF , thresh_level );
central_im  = getCentralAperture( LF );
final_im = sum_im_v + sum_im_h;
%% Plot central image
figure;
imshow(sat_central_im);
title('Central Image');

%% Plotting apertures
figure;
imshow(sum_im_v);
title('Sum Vertical');

figure;
imshow(sum_im_h);
title('SUM Horizontal');
%% Plot final image
final_im = sum_im_v + sum_im_h;
figure;
imshow(final_im)
title('SUM total')

%% Histogram
equalizada=histeq(final_im);
subplot(2,2,1);
imshow(final_im);
title('Imagem Original');
subplot(2,2,2);
imshow(equalizada);
title('Imagem Equalizada');
subplot(2,2,3);
imhist(final_im);
subplot(2,2,4);
imhist(equalizada); 

%% Block Detect
num_of_blocks = 50;
[ res1, mean_std_crack_block1, mean_mean_crack_block1, mean_std_no_crack_block1, mean_mean_no_crack_block1 ] = ...
    block_detect( final_im, num_of_blocks, 0.3, 1);

[ res2, mean_std_crack_block2, mean_mean_crack_block2, mean_std_no_crack_block2, mean_mean_no_crack_block2 ] = ...
    block_detectV2( final_im, num_of_blocks, trained_mean, 5);

% figure;
% imshowpair(res1,res2, 'montage');
% title('Block Detection V1 vs V2');



figure;
subplot(3,3,1);
imshow(central_im);
title('Central Image');
subplot(3,3,2);
imshow(sat_central_im);
title('Central Image Saturated');
subplot(3,3,3);
imshow(sum_im_v);
title('Sum of the vertical Diffs');
subplot(3,3,4);
imshow(sum_im_h);
title('Sum of the horizontal Diffs');
subplot(3,3,5);
imshow(sum_im_t);
title('Sum of all Diffs');
subplot(3,3,6);
imshow(res1);
title('Block Detect v1');
subplot(3,3,7);
imshow(res2);
title('Block Detect v2');






