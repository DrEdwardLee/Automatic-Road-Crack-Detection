function [ output_args ] = plotApertures( top_image, bottom_image, center_image, right_image, left_image )
%   Ploting the RGB pictures
figure;
subplot(3,3,2);
imshow(top_image);
title('Top image');
subplot(3,3,8);
imshow(bottom_image);
title('Bottom image');
subplot(3,3,5);
imshow(center_image);
title('Center image');
subplot(3,3,6);
imshow(right_image);
title('Right image');
subplot(3,3,4);
imshow(left_image);
title('Left image');

end

