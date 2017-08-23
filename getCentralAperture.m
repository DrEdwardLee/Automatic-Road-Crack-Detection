function [ center_im ] = getCentralAperture( LF )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

center_im = uint8(rgb2gray(squeeze(LF(8,8,:,:,1:3)) / 256));


end

