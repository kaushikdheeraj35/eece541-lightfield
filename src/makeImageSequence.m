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

sequence = VideoWriter(outputFile);
open(sequence);
% Sequencing pattern
switch pattern
    case 'zigzag'
        for i = 1:size(images, 1)
            for j = 1:size(images, 2)
                writeVideo(sequence, images{i, j});
            end
        end
    case 'spiral'
        
    otherwise
        error('Invalid pattern.');
end
close(sequence);

end
