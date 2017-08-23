function [ train_mean, train_std ] = train_params( image, num_of_blocks )


row_size = size(image, 1);
column_size = size(image, 2);

row_block_size = floor(row_size/num_of_blocks);
column_block_size = floor(column_size/num_of_blocks);

mean_block = zeros(num_of_blocks*num_of_blocks,1);
std_block = zeros(num_of_blocks*num_of_blocks,1);

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


train_mean = mean(mean_block);
train_std = mean(std_block);
end

