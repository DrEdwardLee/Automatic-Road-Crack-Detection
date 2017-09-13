function [ central_im, sum_im_v, sum_im_h, sum_im_t] = sumAllApertures( LF, thresh_level, num_apertures, edge_line )
im_v = cell(1,num_apertures);
im_h = cell(1,num_apertures);

index = floor((15 - num_apertures)/2);

for i = index:(index + num_apertures)
    
    im_v{(i-index+1)} = uint8(imThresh((rgb2gray(squeeze(LF(edge_line,i,:,:,1:3))/256)), thresh_level) ...
        - imThresh((rgb2gray(squeeze(LF((16-edge_line),i,:,:,1:3))/256)), thresh_level));
    
    im_h{(i-index+1)} = uint8(imThresh((rgb2gray(squeeze(LF(i,edge_line,:,:,1:3))/256)), thresh_level) ....
        - imThresh((rgb2gray(squeeze(LF(i,(16-edge_line),:,:,1:3))/256)), thresh_level));
end

sum_im_v = uint8(zeros(size(im_v{1},1), size(im_v{1},2)));
sum_im_h = uint8(zeros(size(im_v{1},1), size(im_v{1},2)));

for i = 1:size(im_h,2)
    sum_im_v = sum_im_v + im_v{i};
    sum_im_h = sum_im_h + im_h{i};
end

% sum_im_v = sum_im_v/num_apertures;
% sum_im_h = sum_im_h/num_apertures;

sum_im_t = sum_im_v + sum_im_h;
central_im = uint8(imThresh(rgb2gray(squeeze(LF(8,8,:,:,1:3)) / 256), thresh_level));
end

