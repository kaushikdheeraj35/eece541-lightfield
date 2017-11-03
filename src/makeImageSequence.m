function [handle] = makeImageSequence(images, format)

% Chroma downsampling format
switch format
    case '400'
        fwidth = 0.0;
        fheight = 0.0;
    case '411'
        fwidth = 0.25;
        fheight = 1.0;
    case '420'
        fwidth = 0.5;
        fheight = 0.5;
    case '422'
        fwidth = 0.5;
        fheight = 1.0;
    case '444'
        fwidth = 1.0;
        fheight = 1.0;
    otherwise
        error('Unknown chroma downsampling format.')
end
    
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
