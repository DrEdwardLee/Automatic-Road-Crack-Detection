function [gray_top, gray_bottom, gray_center, gray_right, gray_left] = RgbToGray(top, bottom, center, right, left)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
gray_top = uint8(rgb2gray(top) / 256);
gray_bottom = uint8(rgb2gray(bottom) / 256);
gray_center = uint8(rgb2gray(center) / 256);
gray_right = uint8(rgb2gray(right) / 256);
gray_left = uint8(rgb2gray(left) / 256);

end

