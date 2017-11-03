LFUtilProcessWhiteImages;
LFUtilDecodeLytroFolder('C:\Users\david\Desktop\Samples\Images');
%% ff
data_dir = 'C:\Users\david\Desktop\Samples\Images\Cidade Universitária2\'
folder_info =  dir(data_dir);

n_images = uint8(size(folder_info,1));
LF_im = cell(1,n_images-2);
central_im = cell(1,n_images-2);
sat_central_im = cell(1,n_images-2); 
sum_im_v = cell(1,n_images-2);
sum_im_h = cell(1,n_images-2);
sum_im_t = cell(1,n_images-2);
s2 ='t'; 
j = 1;
for i = 1:n_images
s1 = folder_info(i).name(end);
tf = strcmp(s2,s1);
    if tf
        str = strcat(data_dir,folder_info(i).name);
        LF_im{j} = load(str,'LF');
        LF_im{j}.name = folder_info(i).name(1:end-13);
        j = j + 1;
    end    
end

%%
thresh_level = 40;
k=1;
for i = 1:size(LF_im,2)
    [central_im{i}, sat_central_im{i}, sum_im_v{i}, sum_im_h{i}, sum_im_t{i}] = sumAllApertures( LF_im{i}.LF , thresh_level,9,3);   
    if rem(i,6)==0
        figure();
        k=1;
    end
    subplot(3,4,k)
    imshow(central_im{i});
    title(LF_im{i}.name);
    k = k + 1;
    subplot(3,4,k)
    imshow(sum_im_t{i});
    title(LF_im{i}.name);
    k = k + 1;
end

%%

th = 0.03;
mode = 0;

[im1, im1s] = process_LF( sum_im_v{6}, sum_im_h{6},0);
[res1, res1_clean] = block_detectV2( im1, 25,th,mode );
[res1_s, res1_s_clean] = block_detectV2( im1s, 25,th,mode );
imwrite(res1_clean, 'A1a.png')
imwrite(res1_s_clean, 'A1b.png')
[im2, im2s] = process_LF( sum_im_v{7}, sum_im_h{7},0);
[res2, res2_clean] = block_detectV2( im2, 25,th,mode );
[res2_s, res2_s_clean] = block_detectV2(im2s, 25,th,mode );
imwrite(res2_clean, 'B1a.png')
imwrite(res2_s_clean, 'B1b.png')
figure;
subplot(3,3,1);                                                 
imshow(central_im{6});
title('Imagem central');

subplot(3,3,2);
imshow(sum_im_v{6}+sum_im_h{6});
title('Light field processing');

subplot(3,3,3);
imshow(im1);
title('post processing');

subplot(3,3,4);
imshow(im1s);
title('post processing with edge detection');
 
subplot(3,3,5);
imshow(res1);
title('block result');

subplot(3,3,6);
imshow(res1_clean);
title('block result cleaned');

subplot(3,3,7);
imshow(res1_s);
title('block result with edge detection');

subplot(3,3,8);
imshow(res1_s_clean);
title('block result with edge detection cleaned');

figure;
subplot(3,3,1);
imshow(central_im{7});
title('Imagem central')

subplot(3,3,2);
imshow(sum_im_v{7}+sum_im_h{7});
title('Light field processing');

subplot(3,3,3);
imshow(im2);
title('post processing');

subplot(3,3,4);
imshow(im2s);
title('post processing with edge detection');

subplot(3,3,5);
imshow(res2);
title('block result');

subplot(3,3,6);
imshow(res2_clean);
title('block result clean');

subplot(3,3,7);
imshow(res2_s);
title('block result with edge detection');

subplot(3,3,8);
imshow(res2_s_clean);
title('block result with edge detection cleaned');


%%
res = {};
res_clean = {};
k=1;
for i = 1:10
    [res{i}, res_clean{i}] = block_detectV2( im2s, 25,0.01*i,0);

    if rem(i,6)==0
        figure();
        k=1;
    end
    subplot(3,4,k)
    imshow(res{i});
    title(sprintf('Not clean %.d',i));
    k = k + 1;
    subplot(3,4,k)
    imshow(res_clean{i});
    title(sprintf('Clean %d',i));
    k = k + 1;
end








