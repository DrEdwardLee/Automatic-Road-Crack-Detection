function [ res, res_clean ] = block_detectV2( image, num_of_pixels, th, mode)
row_size = size(image, 1);
column_size = size(image, 2);

row_block_num = floor(row_size/num_of_pixels);
column_block_num = floor(column_size/num_of_pixels);

temp_res = zeros(row_block_num, column_block_num);

res = zeros(row_block_num, column_block_num);

k = 1;
% Loop through blocks or regions 
for m = 1:row_block_num
    for n = 1:column_block_num
        % k has the pixel count in each block
        
        %row indexes
        l = (m-1)*num_of_pixels + 1;
        p = (m*num_of_pixels);
        %colum indexes
        q = (n-1)*num_of_pixels + 1;
        o = (n*num_of_pixels);
        
        ones_block = length(find(image(l:p,q:o)));
        temp_res(m, n) = ones_block/(25*25);
        
        if mode
            if ones_block >  th*num_of_pixels*num_of_pixels
                temp_res(m,n) = 1;
            else
                temp_res(m,n) = 0;
            end
        end
        
        k = k + 1;
    end
end   

l = logical(temp_res);
if mode
    l_clean = bwmorph(l,'clean');
    res = temp_res;
else
    l_clean = bwmorph(l,'clean');
    
    for m = 1:size(l_clean,1)
        for n = 1:size(l_clean,2)
           
            if l_clean(m,n)
                if (temp_res(m,n) > th)
                    l_clean(m,n) = 1;
                else
                    l_clean(m,n) = 0;
                end
            end
        end
    end
    res = l;
    l_clean = bwmorph(l_clean,'clean');
end
 
res_clean = l_clean;

% figure();
% subplot(1,2,1);
% imshow(l);
% subplot(1,2,2);
% imshow(l_clean);



end

