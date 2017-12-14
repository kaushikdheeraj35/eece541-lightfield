function sideBySide(leftFileName, rightFileName)
% Autors: SamuelNLP and iGanelin 07/2015
% Notes: Both videos should have the same parameters: fps, size.

nameOut = strcat(rightFileName, '_VS_ref.avi');

vid1 = VideoReader(leftFileName);
vid2 = VideoReader(rightFileName);
frames = vid1.CurrentTime * vid1.FrameRate;

% start video player
%videoPlayer = vision.VideoPlayer;
% new video
outputVideo = VideoWriter(nameOut);
outputVideo.FrameRate = vid1.FrameRate;
open(outputVideo);

while hasFrame(vid1) && hasFrame(vid2)
    img1 = readFrame(vid1);
    img2 = readFrame(vid2);

    imgt = horzcat(img1, img2);
    frames = frames - 1;
    writeVideo(outputVideo, imgt);
end
close(outputVideo);

end
