function makeImageSequence(outputFile, images, format, pattern)

% Chroma downsampling format
switch format
    case '400'
        horizontalSamples = 0;
        verticalSamples = 0;
    case '411'
        horizontalSamples = 4;
        verticalSamples = 1;
    case '420'
        horizontalSamples = 2;
        verticalSamples = 2;
    case '422'
        horizontalSamples = 2;
        verticalSamples = 1;
    case '444'
        horizontalSamples = 1;
        verticalSamples = 1;
    otherwise
        error('Unknown chroma downsampling format.')
end

% Colour format conversion
for i = 1:length(images(:))
    images{i} = rgb2ycbcr(images{i});
end

fileHandle = fopen(outputFile, 'w');
% Sequencing pattern
switch pattern
    case 'line'
        for i = 1:size(images, 1)
            for j = 1:size(images, 2)
                saveYuvFrame(fileHandle, images{i, j}, horizontalSamples, verticalSamples);
            end
        end
    case 'spiral'
        if size(images, 1) ~= size(images, 2)
            error('Spiral pattern currently only works for a square layout.');
        elseif rem(size(images, 1),  2) == 0
            error('Spiral pattern currently only works for odd number side lengths.')
        end
        sideLength = size(images, 1);
        ringCount = (sideLength + 1) / 2;
        curIndices = ones(2, 1) .* ringCount;
        % Ring 1 (centre)
        saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, horizontalSamples, verticalSamples);
        curDirection = [1; 0]; % Down
        % Rings 2 and above
        for ring = 2:ringCount
            % Down
            curIndices = curIndices + curDirection;
            saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, horizontalSamples, verticalSamples);
            % Right
            curDirection = [0 -1; 1 0] * curDirection;
            for i = 1:(ring - 1)* 2 - 1
                curIndices = curIndices + curDirection;
                saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, horizontalSamples, verticalSamples);
            end
            % Up, left, and down
            for sideIdx = 1:3
                curDirection = [0 -1; 1 0] * curDirection;
                for i = 1:(ring - 1) * 2
                    curIndices = curIndices + curDirection;
                    saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, horizontalSamples, verticalSamples);
                end
            end
        end
    otherwise
        error('Invalid pattern.');
end
fclose(fileHandle);

end

function saveYuvFrame(fileHandle, frame, horizontalSamples, verticalSamples)

if length(size(frame)) ~= 3
    error('Expected 3 dimensions.');
end

y = double(frame(:, :, 1));
u = double(frame(:, :, 2));
v = double(frame(:, :, 3));
% TODO: Implement the others. This is for 4:2:0 only
% Reference: https://www.mathworks.com/matlabcentral/fileexchange/11264-matlab-movie-to-yuv-file
u2 = (u(1:2:end, 1:2:end) + u(2:2:end, 1:2:end) + u(1:2:end, 2:2:end) + u(2:2:end, 2:2:end)) ./ 4;
v2 = (v(1:2:end, 1:2:end) + v(2:2:end, 1:2:end) + v(1:2:end, 2:2:end) + v(2:2:end, 2:2:end)) ./ 4;

fwrite(fileHandle, uint8(y'), 'uchar');
fwrite(fileHandle, uint8(u2'), 'uchar');
fwrite(fileHandle, uint8(v2'), 'uchar');

end
