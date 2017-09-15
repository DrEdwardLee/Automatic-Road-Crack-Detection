function [ sub_ap ] = getSubAperture( LF, i, j )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

sub_ap = uint8(rgb2gray(squeeze(LF(i,j,:,:,1:3)) / 256));


end
