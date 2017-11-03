function [ p_final_im, p_final_im_sobel ] = process_LF( sum_im_v, sum_im_h, verbose )

H = fspecial('sobel');
%Apply a sobel filter that emphasizes horizontal edges
h_sobel_im = imfilter(sum_im_v,H,'replicate');
%Apply a sobel filter that emphasizes vertical edges
v_sobel_im = imfilter(sum_im_h,H','replicate');
final_sobel_im = h_sobel_im + v_sobel_im;
final_im = sum_im_v + sum_im_h;

if verbose
    figure;
    subplot(3,2,1)
    imshow(sum_im_h);
    title('Original sum im h');
    subplot(3,2,2)
    imshow(v_sobel_im);
    title('Sobel vertical');
    subplot(3,2,3)
    imshow(sum_im_v);
    title('Original sum im v');
    subplot(3,2,4)
    imshow(h_sobel_im);
    title('Sobel horizontal');
    subplot(3,2,5)
    imshow(final_im);
    title('Original Final Im');
    subplot(3,2,6)
    imshow(final_sobel_im);
    title('Sobel Final Im');
end

median_im = medfilt2(final_im, [3 3]);
median_sobel_im = medfilt2(final_sobel_im, [3 3]);

if verbose
    figure;
    subplot(2,2,1)
    imshow(final_sobel_im);
    title('Sobel Im');
    subplot(2,2,2);
    imshow(median_sobel_im);
    title('Median of the Sobel Im');
    subplot(2,2,3)
    imshow(final_im);
    title(' Final Im without Sobel');
    subplot(2,2,4);
    imshow(median_im);
    title('Median Final Im');
end


p_final_im_sobel = pixelAnalysis(median_sobel_im,2,0.15,0.99,0.15,verbose);
p_final_im = pixelAnalysis(median_im,2,0.15,0.99,0.15,verbose);
% 
%     figure;
%     subplot(1,2,1);
%     imshow(p_final_im);
%     title('Final Result without Sobel');
%     subplot(1,2,2);
%     imshow(p_final_im_sobel);
%     title('Final Result with sobel and Median');
%     

end

