addpath('yuv')

leftFileName = 'D:/Repos/eece541-lightfield/assets/subjective_tests/original_420.avi';
for gop = [4 8 16]
    for qp = [24 28 32 36 40]
        rightFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/raster_420/recgop%dqp%d.avi', gop, qp);
        sideBySide(leftFileName, rightFileName);
    end
end

for gop = [4 8 16]
    for qp = [24 28 32 36 40]
        rightFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/spiral_420/recgop%dqp%d.avi', gop, qp);
        sideBySide(leftFileName, rightFileName);
    end
end

for gop = [4 8]
    for qp = [24 28 32 36 40]
        rightFileName = sprintf('D:/Repos/eece541-lightfield/assets/subjective_tests/mvc_420/recgop%dqp%d.avi', gop, qp);
        sideBySide(leftFileName, rightFileName);
    end    
end
