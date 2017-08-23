function [ central_im, sum_im_v, sum_im_h, sum_im_t] = sumAllApertures( LF, thresh_level )
im_v = cell(1,13);
im_h = cell(1,13);

for i = 2:14
    
    im_v{(i-1)} = uint8(imThresh((rgb2gray(squeeze(LF(1,i,:,:,1:3)) / 256)), thresh_level) ...
        - imThresh((rgb2gray(squeeze(LF(15,i,:,:,1:3)) / 256)), thresh_level));
    
    im_h{(i-1)} = uint8(imThresh((rgb2gray(squeeze(LF(i,1,:,:,1:3)) / 256)), thresh_level) ....
        - imThresh((rgb2gray(squeeze(LF(i,15,:,:,1:3)) / 256)), thresh_level));
end

sum_im_v = uint8(zeros(size(im_v{1},1), size(im_v{1},2)));
sum_im_h = uint8(zeros(size(im_v{1},1), size(im_v{1},2)));

for i = 1:13
    sum_im_v = sum_im_v + im_v{i};
    sum_im_h = sum_im_h + im_h{i};
end

sum_im_t = sum_im_v + sum_im_h;
central_im = uint8(imThresh(rgb2gray(squeeze(LF(8,8,:,:,1:3)) / 256), thresh_level));
end

