addpath('yuv')

if 0
for gop = [4 8 16]
    for qp = [24 28 32 36 40]
        inputFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/raster_420/recgop%dqp%d.yuv', gop, qp);
        outputFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/raster_420/recgop%dqp%d.avi', gop, qp);
        yuv2avi(inputFileName, [1024 1024], outputFileName, 'None', 5, 'YUV420_8');
    end
end

for gop = [4 8 16]
    for qp = [24 28 32 36 40]
        inputFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/spiral_420/recgop%dqp%d.yuv', gop, qp);
        outputFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/spiral_420/recgop%dqp%d.avi', gop, qp);
        yuv2avi(inputFileName, [1024 1024], outputFileName, 'None', 5, 'YUV420_8');
    end
end

for gop = [4 8]
    for qp = [24 28 32 36 40]
        inputFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/mvc_420/recgop%dqp%d.yuv', gop, qp);
        outputFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/mvc_420/recgop%dqp%d.avi', gop, qp);
        yuv2avi(inputFileName, [1024 1024], outputFileName, 'None', 5, 'YUV420_8');
    end    
end
end

inputFileName = 'D:/Repos/eece541-lightfield/assets/subjective_tests/original_420.yuv';
outputFileName = 'D:/Repos/eece541-lightfield/assets/subjective_tests/original_420.avi';
yuv2avi(inputFileName, [1024 1024], outputFileName, 'None', 5, 'YUV420_8');
