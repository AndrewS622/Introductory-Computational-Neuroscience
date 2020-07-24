clear all

%% Make mach band image

sz = 1000;
slope = -.003;
[x,y]=meshgrid(-sz/2:sz/2,-sz/2:sz/2);
im_mach = max(-.5,min(.5,x*slope));

imagesc(im_mach)
colormap gray
title('Mach Bands');


%% Create and plot DoG filter

dog = fspecial('gaussian',51,3)-fspecial('gaussian',51,7);                  %Subtract two 51x51 gaussians
figure
surf(dog)                                                                   %Surface plot
colormap gray
title('Difference of Gaussians Filter');

%% Convolve image and plot the result

imagesc(im_mach)
figure
res = conv2(im_mach,dog,'valid');                                           %2D convolution of image and filter

imagesc(res)                                                                %Plot
colormap gray
title('Filtered Mach Bands');

dog2=dog+.00001;                                                            %Luminance-sensitive fulter
surf(dog2);
title('Luminance-Sensitive Filter');
colormap gray
res2=conv2(im_mach,dog2,'valid');

figure
imagesc(res2)
colormap gray
title('Luminance-Sensitive Filtered Mach Bands');


%% Create checkerboard image

sz = 1000;
stripe_width = 10;
num_stripes = 10;

im_cb = -.5*ones(sz,sz);

for c = round(linspace(1,sz,num_stripes))
    %%c
    im_cb(c:c+stripe_width,:) = .5;
    im_cb(:,c:c+stripe_width) = .5;
end

figure
imagesc(im_cb)
colormap gray
title('Checkerboard');

% Convolve image and plot the result

rescheck = conv2(im_cb,dog,'valid');

figure
imagesc(rescheck)
colormap gray
title('Filtered Checkerboard');

dog3=fspecial('gaussian',51,.5)-fspecial('gaussian',51,1);                  %Higher resolution filter
resfovea=conv2(im_cb,dog3,'valid');
figure
surf(dog3)
colormap gray
title('Higher Resolution Filter');

figure
imagesc(resfovea)
colormap gray
title('Higher Resolution Filtered Checkerboard');

%% Load built-in natural image
im_natural = double(rgb2gray(imread('peppers.png')));
figure
imagesc(im_natural)
colormap gray
title('Peppers');

%% Convolve and plot the result

resnat1 = conv2(im_natural,dog,'valid');                                    %Convolve with first filter
figure
imagesc(resnat1)
colormap gray
title('Filtered Peppers');

resnat2 = conv2(im_natural,dog3,'valid');                                   %Convolve with second filter
figure
imagesc(resnat2)
colormap gray
title('Higher Resolution Filtered Checkerboard');