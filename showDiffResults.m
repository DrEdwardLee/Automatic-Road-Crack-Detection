function [ output_args ] = showDiffResults( LF , thresh_level)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


im = cell(1,40);
k=1;
q = 1;
figure;
for i=1:15
    for j = 1:15
    [im{k}, sum_im_v, sum_im_h, ss] = sumAllApertures( LF , thresh_level,j,i);
    subplot(15,15,k)
%     q = 255.0/max(max(im{k}));
    imshow(im{k});
    title(sprintf('Edge line: %d \n Num o apertures: %d',i,j));
    k=k+1;
    end
end

end

