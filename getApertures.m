function [ top, bottom, center, right, left ] = getApertures( LF )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
top = squeeze(LF(1,8,:,:,1:3));
bottom = squeeze(LF(15,8,:,:,1:3));
center = squeeze(LF(8,8,:,:,1:3));
right = squeeze(LF(8,15,:,:,1:3));
left = squeeze(LF(8,1,:,:,1:3));


end


