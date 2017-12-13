function resequenceImages(outputFile, inputFile, width, height)
%READIMAGESEQUENCE Summary of this function goes here
%   Detailed explanation goes here

inputFileHandle = fopen(inputFile, 'r');
byteStream = fread(inputFileHandle, '*uchar');
fclose(inputFileHandle);

frameLength = 1.5 * width * height; % TODO: Works for 420 only for now
sideLength = 17;

frames = cell(sideLength, sideLength);
for i = 1:sideLength
    for j = 1:sideLength
        k = (i - 1) * sideLength + j;
        frames{i, j} = byteStream(((k - 1) * frameLength + 1):(k * frameLength));
    end
end

outputFileHandle = fopen(outputFile, 'w');
% TODO: Resequence from line to spiral only
ringCount = (sideLength + 1) / 2;
curIndices = ones(2, 1) .* ringCount;
% Ring 1 (centre)
fwrite(outputFileHandle, frames{curIndices(1), curIndices(2)}, 'uchar');
curDirection = [1; 0]; % Down
% Rings 2 and above
for ring = 2:ringCount
    % Down
    curIndices = curIndices + curDirection;
    fwrite(outputFileHandle, frames{curIndices(1), curIndices(2)}, 'uchar');
    % Right
    curDirection = [0 -1; 1 0] * curDirection;
    for i = 1:(ring - 1)* 2 - 1
        curIndices = curIndices + curDirection;
        fwrite(outputFileHandle, frames{curIndices(1), curIndices(2)}, 'uchar');
    end
    % Up, left, and down
    for sideIdx = 1:3
        curDirection = [0 -1; 1 0] * curDirection;
        for i = 1:(ring - 1) * 2
            curIndices = curIndices + curDirection;
            fwrite(outputFileHandle, frames{curIndices(1), curIndices(2)}, 'uchar');
        end
    end
end
fclose(outputFileHandle);

end
