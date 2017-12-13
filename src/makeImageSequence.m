function makeImageSequence(outputFile, images, pattern, chromaResampler)

if length(size(images)) ~= 2
    error('Only 2D image arrays are supported.');
end

% Colour format conversion
for i = 1:length(images(:))
    images{i} = rgb2ycbcr(images{i});
end

if (nargin >= 4)
    processFrame = @(file, frame) ...
        writeFrame(file, frame, chromaResampler);
else
    processFrame = @(file, frame) writeFrame(file, frame);
end

fileHandle = fopen(outputFile, 'w');
% Sequencing pattern
switch pattern
    case 'line'
        for i = 1:size(images, 1)
            for j = 1:size(images, 2)
                processFrame(fileHandle, images{i, j});
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
        processFrame(fileHandle, images{curIndices(1), curIndices(2)});
        curDirection = [1; 0]; % Down
        % Rings 2 and above
        for ring = 2:ringCount
            % Down
            curIndices = curIndices + curDirection;
            processFrame(fileHandle, images{curIndices(1), curIndices(2)});
            % Right
            curDirection = [0 -1; 1 0] * curDirection;
            for i = 1:(ring - 1)* 2 - 1
                curIndices = curIndices + curDirection;
                processFrame(fileHandle, images{curIndices(1), curIndices(2)});
            end
            % Up, left, and down
            for sideIdx = 1:3
                curDirection = [0 -1; 1 0] * curDirection;
                for i = 1:(ring - 1) * 2
                    curIndices = curIndices + curDirection;
                    processFrame(fileHandle, images{curIndices(1), curIndices(2)});
                end
            end
        end
    otherwise
        error('Invalid pattern.');
end
fclose(fileHandle);

end
