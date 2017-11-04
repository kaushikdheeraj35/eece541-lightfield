%% EECE 541 Light Field Project

workingDir = '../resources/4_Compression/Content/Camera array/Lego Knights/rectified';
images = loadImageArray(workingDir, '*.png', 17, 17);
makeImageSequence('output.yuv', images, '420', 'spiral');
