function [diff_top_bottom, diff_right_left, sum_im] = diffImages(gray_top, gray_bottom, gray_center, gray_right, gray_left)

diff_top_center = gray_center - gray_top;
diff_bottom_center = gray_center - gray_bottom;
diff_right_center = gray_center - gray_right;
diff_left_center = gray_center - gray_left;
% plotApertures(diff_top_center, diff_bottom_center, gray_center, diff_right_center, diff_left_center);

% smooth_diff_top_center = smooth_gray_center - smooth_gray_top;
% smooth_diff_bottom_center = smooth_gray_center - smooth_gray_bottom;
% smooth_diff_right_center = smooth_gray_center - smooth_gray_right;
% smooth_diff_left_center = smooth_gray_center - smooth_gray_left;

% plotApertures(smooth_diff_top_center, smooth_diff_bottom_center, smooth_gray_center, smooth_diff_right_center, smooth_diff_left_center);

% Plot the diference between the more distant images

diff_top_bottom = gray_top - gray_bottom;
diff_right_left = gray_right - gray_left;
sum_im = diff_top_bottom + diff_right_left;

% s_diff_top_bottom = smooth_gray_top - smooth_gray_bottom;
% s_diff_right_left = smooth_gray_right - smooth_gray_left;
%     plotDiffDst(smooth_gray_top, s_diff_top_bottom, smooth_gray_bottom, smooth_gray_right, s_diff_right_left, smooth_gray_left)

end

