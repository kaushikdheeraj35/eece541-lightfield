function makeImageSequence(outputFile, images, pattern, chromaResampler)

if length(size(images)) ~= 2
    error('Only 2D image arrays are supported.');
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
                saveYuvFrame(fileHandle, images{i, j}, chromaResampler);
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
        saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, chromaResampler);
        curDirection = [1; 0]; % Down
        % Rings 2 and above
        for ring = 2:ringCount
            % Down
            curIndices = curIndices + curDirection;
            saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, chromaResampler);
            % Right
            curDirection = [0 -1; 1 0] * curDirection;
            for i = 1:(ring - 1)* 2 - 1
                curIndices = curIndices + curDirection;
                saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, chromaResampler);
            end
            % Up, left, and down
            for sideIdx = 1:3
                curDirection = [0 -1; 1 0] * curDirection;
                for i = 1:(ring - 1) * 2
                    curIndices = curIndices + curDirection;
                    saveYuvFrame(fileHandle, images{curIndices(1), curIndices(2)}, chromaResampler);
                end
            end
        end
    otherwise
        error('Invalid pattern.');
end
fclose(fileHandle);

end

function saveYuvFrame(fileHandle, frame, chromaResampler)

if length(size(frame)) ~= 3
    error('Expected 3 dimensions.');
end

y = double(frame(:, :, 1));
u = double(frame(:, :, 2));
v = double(frame(:, :, 3));
[u2, v2] = step(chromaResampler, u, v);

fwrite(fileHandle, uint8(y'), 'uchar');
fwrite(fileHandle, uint8(u2'), 'uchar');
fwrite(fileHandle, uint8(v2'), 'uchar');

end
