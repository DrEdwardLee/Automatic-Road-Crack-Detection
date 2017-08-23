function [ feature_vector ] = LF_LBP( LF, num_of_regions )
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

row_size = size(gray_center_image, 1);
column_size = size(gray_center_image, 2);

row_block_size = floor(row_size/num_of_regions);
column_block_size = floor(column_size/num_of_regions);
total_LBP_features = [];
% total_LBP_features = zeros(row_block_size*column_block_size,num_of_regions*num_of_regions);
block_LBP_features = zeros(row_block_size*column_block_size,4);
dec_block_LBP_features = zeros(row_block_size*column_block_size,1);

% Loop through blocks or regions 
for m = 1:num_of_regions
    for n = 1:num_of_regions
        % k has the pixel count in each block
        k = 1;
        % Loop inside the block
        for i = ((m-1)*row_block_size + 1):(m*row_block_size)
            for j = ((n-1)*column_block_size + 1):(n*column_block_size)
                % Compares to the top image
                if gray_center_image(i,j) > gray_top_image(i,j)
                block_LBP_features(k, 1) = 1;
                else
                block_LBP_features(k, 1) = 0;    
                end
                % Compares to the right image            
                if gray_center_image(i,j) > gray_right_image(i,j)
                block_LBP_features(k, 2) = 1;    
                else
                block_LBP_features(k, 2) = 0;    
                end
                % Compares to the bottom image
                if gray_center_image(i,j) > gray_bottom_image(i,j)
                block_LBP_features(k, 3) = 1;    
                else
                block_LBP_features(k, 3) = 0;    
                end
                % Compares to the left image
                if gray_center_image(i,j) > gray_left_image(i,j)
                block_LBP_features(k, 4) = 1;   
                else
                block_LBP_features(k, 4) = 0;    
                end
            k = k + 1;
            end
        end
        % Binary word to decimal
        for i = 1:size(dec_block_LBP_features, 1)
            dec_block_LBP_features(i) = bi2de(block_LBP_features(i,:)); 
        end
        
        % Concatenating 
        total_LBP_features = [total_LBP_features, dec_block_LBP_features];  
    end
end
feature_vector = total_LBP_features;
end
