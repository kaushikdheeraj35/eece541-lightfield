function [handle] = makeImageSequence(workingDir, )

handle = 1;
imageCount = 1;

for i = 1:imageCount
    ycbcrImage = rgb2ycbcr(rgbImage);
    imshow(ycbcrImage);
end

end
