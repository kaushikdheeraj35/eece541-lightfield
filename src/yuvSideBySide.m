function yuvSideBySide(outputFileName, inputFileName1, inputFileName2, width, height, frameCount, chromaFormat)
%YUVSIDEBYSIDE Summary of this function goes here
%   Detailed explanation goes here

yLen = width * height;
switch chromaFormat
    case '420'
        uLen = yLen / 4;
        vLen = yLen / 4;
    case '444'
        uLen = yLen;
        vLen = yLen;
    otherwise
        error('Invalid chroma format.');
end
inputFile1 = fopen(inputFileName1, 'r');
inputFile2 = fopen(inputFileName2, 'r');
y1 = nan(width * height, 1);
y2 = nan(width * height, 1);
for frameIdx = 1:frameCount
    for i = 1:yLen
        y1((frameIdx - 1) * yLen)
    end
    y1 = fread();
    video2
end

end

