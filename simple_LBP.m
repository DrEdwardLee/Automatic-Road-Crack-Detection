function [ feature_vector ] = simple_LBP( LF )
%% Simple LBP

% Geting the images from the light Field
top_image = squeeze(LF(5,1,:,:,1:3));
bottom_image = squeeze(LF(5,10,:,:,1:3));
center_image = squeeze(LF(5,5,:,:,1:3));
right_image = squeeze(LF(10,5,:,:,1:3));
left_image = squeeze(LF(1,5,:,:,1:3));

% RGB to Gray 
gray_center_image = rgb2gray(center_image);
gray_top_image = rgb2gray(top_image);
gray_bottom_image = rgb2gray(bottom_image);
gray_left_image = rgb2gray(left_image);
gray_right_image = rgb2gray(right_image);

LBP_features = zeros(276875,4);
for i = 1:size(gray_center_image, 1)
    for j = 1:size(gray_center_image, 2)
        if gray_center_image(i,j) > gray_top_image(i,j)
            LBP_features((i-1)*625 + j, 1) = 1;
        else
            LBP_features((i-1)*625 + j, 1) = 0;
        end
        
        if gray_center_image(i,j) > gray_right_image(i,j)
            LBP_features((i-1)*625 + j, 2) = 1;
        else
            LBP_features((i-1)*625 + j, 2) = 0;
        end
        
        if gray_center_image(i,j) > gray_bottom_image(i,j)
            LBP_features((i-1)*625 + j, 3) = 1;
        else
            LBP_features((i-1)*625 + j, 3) = 0;
        end
        
        if gray_center_image(i,j) > gray_left_image(i,j)
            LBP_features((i-1)*625 + j, 4) = 1;
        else
            LBP_features((i-1)*625 + j, 4) = 0;
        end        
    end
end
dec_LBP_features = zeros(size(LBP_features, 1), 1);
for i = 1:size(LBP_features, 1)
    dec_LBP_features(i) = bi2de(LBP_features(i,:)); 
end
feature_vector = dec_LBP_features;
end

