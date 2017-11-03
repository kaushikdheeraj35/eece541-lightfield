%% EECE 541 Light Field Project

workingDir = '../resources/4_Compression/Content/Camera array/Lego Knights/rectified';
fileNames = ls(strcat(workingDir, '/*.png'));
for i = 1:17
    image = imread(strtrim(fileNames(i, :)));
end
