function [ output_args ] = showSubApertures(LF)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
im = cell(1,40);
k=1;
q = 1;
figure;
for i=1:15
    for j = 1:15
    [im{k}] = getSubAperture( LF, i, j);
    subplot(15,15,k)
%     q = 255.0/max(max(im{k}));
    imshow(im{k});
%     title(sprintf('Edge line: %d \n Num o apertures: %d',i,j));
    k=k+1;
    end
end


end

