function [ output_args ] = showDiffResults( LF , thresh_level)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


im = cell(1,40);
k=1;
figure;
for i=1:2:8
    for j = 1:2:10
    [sat_central_im, sum_im_v, sum_im_h, im{k}] = sumAllApertures( LF , thresh_level,j,i);
    subplot(4,5,k)
    imshow(im{k});
    title(sprintf('Edge line: %d \n Num o apertures: %d',i,j));
    k=k+1;
    end
end

end

