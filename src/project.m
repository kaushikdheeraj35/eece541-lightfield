%% EECE 541 Light Field Project

%% Load the images
workingDir = '../resources/4_Compression/Content/Camera array/Lego Knights/rectified';
images = loadImageArray(workingDir, '*.png', 17, 17);

%% Downsize the images (Do not perform this step when collecting final results)
for i = 1:numel(images)
    %images{i} = imresize(images{i}, 0.25); % 0.25: 1024x1024 -> 256x256
end

%% Chroma downsampling settings
% For references, see:
% https://www.mathworks.com/help/vision/ref/vision.chromaresampler-system-object.html?requestedDomain=www.mathworks.com
% https://www.mathworks.com/help/vision/ref/chromaresampling.html
chromaResampler = vision.ChromaResampler('Resampling', '4:4:4 to 4:2:0 (MPEG1)');

%% Generate an image sequence
makeImageSequence('../assets/subjective_tests/original_444.yuv', images, 'raster');
makeImageSequence('../assets/subjective_tests/original_420.yuv', images, 'raster', chromaResampler);
resequenceImages('../assets/subjective_tests/original_444.yuv', '../assets/subjective_tests/original_444.yuv', 'raster', '444', 1024, 1024);
resequenceImages('../assets/subjective_tests/original_420.yuv', '../assets/subjective_tests/original_420.yuv', 'raster', '420', 1024, 1024);
%% Compression
% Try different QP, image ordering, encoder configurations, etc.
