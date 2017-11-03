function makeImageSequence(outputFile, images, format, pattern)

% Chroma downsampling format
switch format
    case '400'
        fwidth = 0.0;
        fheight = 0.0;
    case '411'
        fwidth = 0.25;
        fheight = 1.0;
    case '420'
        fwidth = 0.5;
        fheight = 0.5;
    case '422'
        fwidth = 0.5;
        fheight = 1.0;
    case '444'
        fwidth = 1.0;
        fheight = 1.0;
    otherwise
        error('Unknown chroma downsampling format.')
end

% Colour format conversion
for i = 1:length(images(:))
    images{i} = rgb2ycbcr(images{i});
end

fileHandle = fopen(outputFile, 'w');
% TODO: Add a waitbar?
% Sequencing pattern
switch pattern
    case 'zigzag'
        for i = 1:size(images, 1)
            for j = 1:size(images, 2)
                saveYuvFrame(fileHandle, images{i, j}, fwidth, fheight);
            end
        end
    case 'spiral'
        if size(images, 1) ~= size(images, 2)
            error('Spiral pattern currently only works for a square layout.');
        elseif rem(size(images, 1),  2) == 0
            error('Spiral pattern currently only works for odd number side lengths.')
        end
        dim = size(images, 1);
        for i = 1:dim
            % TODO: WIP
        end
    otherwise
        error('Invalid pattern.');
end
fclose(fileHandle);

end

function saveYuvFrame(fileHandle, frame, fwidth, fheight)

if length(size(frame)) ~= 3
    error('Expected 3 dimensions.');
end

y = double(frame(:, :, 1));
u = double(frame(:, :, 2));
v = double(frame(:, :, 3));
% TODO: Implement the others. This is for 4:2:0 only
% FIXME: Not quite right yet?
% Reference: https://www.mathworks.com/matlabcentral/fileexchange/11264-matlab-movie-to-yuv-file
% Check this? https://stackoverflow.com/questions/15423132/convert-rgb-image-to-yuv420-image-by-matlab
u2 = (u(1:2:end, 1:2:end) + u(2:2:end, 1:2:end) + u(1:2:end, 2:2:end) + u(2:2:end, 2:2:end)) ./ 4;
v2 = (v(1:2:end, 1:2:end) + v(2:2:end, 1:2:end) + v(1:2:end, 2:2:end) + v(2:2:end, 2:2:end)) ./ 4;

fwrite(fileHandle, uint8(y'), 'uchar');
fwrite(fileHandle, uint8(u2'), 'uchar');
fwrite(fileHandle, uint8(v2'), 'uchar');

end
