function [handle] = makeImageSequence(workingDir)

handle = 1;
imageCount = 1;

outputVideo = VideoWriter(fullfile(workingDir, 'output.yuv'));
for i = 1:imageCount
    ycbcrImage = rgb2ycbcr(rgbImage);
    %imshow(ycbcrImage);
    writeVideo(outputVideo, ycbcrImage);
end

close(outputVideo);

end
