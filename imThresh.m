function [ thresh_im ] = imThresh( im, level )

n_rows = size(im,1);
n_colums = size(im,2);
thresh_im = zeros(n_rows,n_colums);
m = level;
for i = 1:n_rows
    for j = 1:n_colums
        if(im(i,j) > m)
        
        thresh_im(i,j) = m;
        else
        thresh_im(i,j) =  im(i,j);   
        end
    end
end

end

 