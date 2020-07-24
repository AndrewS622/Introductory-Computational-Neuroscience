function plotImgs(imgs)
% plot images from a stretched out form

origSize = [1024, 1536];

for col = 1:3
    figure(col)                                                             %create figure
    currImg = imgs(:, col);                                                 %take column associated with image
    toPlot = reshape( currImg, origSize);                                   %reshapes column to 1024x1536 image
    imshow( toPlot,[])                                                      %plot with scaled pixels based on min and max values in image
end


end

