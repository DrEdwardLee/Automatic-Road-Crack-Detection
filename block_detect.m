function [ res, mean_std_crack_block, mean_mean_crack_block, mean_std_no_crack_block, mean_mean_no_crack_block ] = block_detect( image, num_of_blocks, sigma_m, sigma_s )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
row_size = size(image, 1);
column_size = size(image, 2);

row_block_size = floor(row_size/num_of_blocks);
column_block_size = floor(column_size/num_of_blocks);

mean_block = zeros(num_of_blocks*num_of_blocks,1);
std_block = zeros(num_of_blocks*num_of_blocks,1);
res = zeros(row_size, column_size);

k = 1;
% Loop through blocks or regions 
for m = 1:num_of_blocks
    for n = 1:num_of_blocks
        % k has the pixel count in each block
        
        %row indexes
        l = (m-1)*row_block_size + 1;
        p = (m*row_block_size);
        %colum indexes
        q = (n-1)*column_block_size + 1;
        o = (n*column_block_size);
     
        mean_block(k) = mean2(image(l:p,q:o));        
        std_block(k) = std2(image(l:p,q:o));
        
        k = k + 1;
    end
end   


max_mean = max(mean_block);
min_std = min(std_block);

block_label = zeros(num_of_blocks*num_of_blocks,1);

k = 1;
% Loop through blocks or regions 
for m = 1:num_of_blocks
    for n = 1:num_of_blocks
        % k has the pixel count in each block
        %row indexes
        l = (m-1)*row_block_size + 1;
        p = (m*row_block_size);
        %colum indexes
        q = (n-1)*column_block_size + 1;
        o = (n*column_block_size);
     
        if mean2(image(l:p,q:o)) < (max_mean*(sigma_m))
           res(l:p,q:o) = 0;
           block_label(k) = 0;
        else
           res(l:p,q:o) = 256;
           block_label(k) = 1;
        end
        k = k + 1;       
    end
end

mean_std_crack_block = mean(std_block(find(block_label)));
mean_mean_crack_block = mean(mean_block(find(block_label)));

mean_std_no_crack_block = mean(std_block(find(~block_label)));
mean_mean_no_crack_block = mean(mean_block(find(~block_label)));

end

