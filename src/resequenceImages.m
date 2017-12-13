function resequenceImages(outputFile, inputFiles, inputPattern, chromaFormat, width, height)
%READIMAGESEQUENCE Summary of this function goes here
%   Detailed explanation goes here

byteStream = [];
for i = 1:size(inputFiles, 1)
    inputFileHandle = fopen(strtrim(inputFiles(i, :)), 'r');
    byteStream = [byteStream; fread(inputFileHandle, '*uchar')];
    fclose(inputFileHandle);
end

switch chromaFormat
    case '420'
        frameLength = 1.5 * width * height;
    case '444'
        frameLength = 3.0 * width * height;
    otherwise
        error('Invalid chroma format.');
end
sideLength = 17;

frames = cell(sideLength, sideLength);
switch inputPattern
    case 'raster'
        for i = 1:sideLength
            for j = 1:sideLength
                k = (i - 1) * sideLength + j;
                frames{i, j} = byteStream(((k - 1) * frameLength + 1):(k * frameLength));
            end
        end
    case 'spiral'
        if size(frames, 1) ~= size(frames, 2)
            error('Spiral pattern currently only works for a square layout.');
        elseif rem(size(frames, 1),  2) == 0
            error('Spiral pattern currently only works for odd number side lengths.')
        end
        sideLength = size(frames, 1);
        ringCount = (sideLength + 1) / 2;
        curIndices = ones(2, 1) .* ringCount;
        % Ring 1 (centre)
        k = 1;
        frames{curIndices(1), curIndices(2)} = ...
            byteStream(((k - 1) * frameLength + 1):(k * frameLength));
        curDirection = [1; 0]; % Down
        % Rings 2 and above
        for ring = 2:ringCount
            % Down
            curIndices = curIndices + curDirection;
            k = k + 1;
            frames{curIndices(1), curIndices(2)} = ...
                byteStream(((k - 1) * frameLength + 1):(k * frameLength));
            % Right
            curDirection = [0 -1; 1 0] * curDirection;
            for i = 1:(ring - 1)* 2 - 1
                curIndices = curIndices + curDirection;
                k = k + 1;
                frames{curIndices(1), curIndices(2)} = ...
                    byteStream(((k - 1) * frameLength + 1):(k * frameLength));
            end
            % Up, left, and down
            for sideIdx = 1:3
                curDirection = [0 -1; 1 0] * curDirection;
                for i = 1:(ring - 1) * 2
                    curIndices = curIndices + curDirection;
                    k = k + 1;
                    frames{curIndices(1), curIndices(2)} = ...
                        byteStream(((k - 1) * frameLength + 1):(k * frameLength));
                end
            end
        end
    otherwise
        error('Invalid pattern.');
end

% Resequence to line
outputFileHandle = fopen(outputFile, 'w');
for rowIdx = 7:11 % Show the middle 5 rows only
    if rem(rowIdx, 2) == 1
        colRange = 1:size(frames, 2);
    else
        colRange = size(frames, 2):-1:1;
    end
    for colIdx = colRange
        fwrite(outputFileHandle, frames{rowIdx, colIdx}, 'uchar');
    end
end
fclose(outputFileHandle);

end
