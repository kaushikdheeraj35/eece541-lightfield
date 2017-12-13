function writeFrame(fileHandle, frame, chromaResampler)
%WRITEFRAME Summary of this function goes here
%   Detailed explanation goes here
if length(size(frame)) ~= 3
    error('Expected 3 dimensions.');
end

y = double(frame(:, :, 1));
u = double(frame(:, :, 2));
v = double(frame(:, :, 3));
if (nargin >= 3)
    [u2, v2] = step(chromaResampler, u, v);
else
    u2 = u; v2 = v;
end

fwrite(fileHandle, uint8(y'), 'uchar');
fwrite(fileHandle, uint8(u2'), 'uchar');
fwrite(fileHandle, uint8(v2'), 'uchar');

end
