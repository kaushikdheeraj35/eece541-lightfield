function [images] = loadImageArray(fileDir, filter, rowCount, colCount)
%LOADIMAGEARRAY Summary of this function goes here
%   Detailed explanation goes here
fileNames = ls(strcat(fileDir, '/', filter));
if size(fileNames, 1) ~= rowCount * colCount
    error('Expected %d files but found only %d.', rowCount * colCount, size(fileNames, 1));
end

images = cell(rowCount, colCount);
for i = 1:rowCount
    for j = 1:colCount
        images{i, j} = imread(fullfile(fileDir, strtrim(fileNames((i - 1) * rowCount + j, :))));
    end
end

end
