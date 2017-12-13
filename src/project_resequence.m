%% EECE 541 Light Field Project
% Resequence videos to spiral for subjective tests

for gop = [4 8 16]
    for qp = [24 28 32 36 40]
       inputFile = sprintf('../assets/single_view_444/recgop%dqp%d.yuv', gop, qp);
       outputFile = sprintf('../assets/subjective_tests/spiral_444/recgop%dqp%d.yuv', gop, qp);
       resequenceImages(outputFile, inputFile, 'spiral', '444', 1024, 1024);
    end
end

for gop = [4 8]
    for qp = [24 28 32 36 40]
        inputFiles = [
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_0.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_1.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_2.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_3.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_4.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_5.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_6.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_7.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_8.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_9.yuv ', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_10.yuv', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_11.yuv', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_12.yuv', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_13.yuv', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_14.yuv', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_15.yuv', gop, qp);
            sprintf('../assets/mvc/recMvc420Gop%dQp%d_16.yuv', gop, qp);
        ];
        outputFile = sprintf('../assets/subjective_tests/mvc_420/recgop%dqp%d.yuv', gop, qp);
        resequenceImages(outputFile, inputFiles, 'raster', '420', 1024, 1024);
    end
end

% inputFiles = [
%     '../assets/mvc/mvc_420_0.yuv ';
%     '../assets/mvc/mvc_420_1.yuv ';
%     '../assets/mvc/mvc_420_2.yuv ';
%     '../assets/mvc/mvc_420_3.yuv ';
%     '../assets/mvc/mvc_420_4.yuv ';
%     '../assets/mvc/mvc_420_5.yuv ';
%     '../assets/mvc/mvc_420_6.yuv ';
%     '../assets/mvc/mvc_420_7.yuv ';
%     '../assets/mvc/mvc_420_8.yuv ';
%     '../assets/mvc/mvc_420_9.yuv ';
%     '../assets/mvc/mvc_420_10.yuv';
%     '../assets/mvc/mvc_420_11.yuv';
%     '../assets/mvc/mvc_420_12.yuv';
%     '../assets/mvc/mvc_420_13.yuv';
%     '../assets/mvc/mvc_420_14.yuv';
%     '../assets/mvc/mvc_420_15.yuv';
%     '../assets/mvc/mvc_420_16.yuv';
% ];
% outputFile = '../assets/mvc_420_spiral.yuv';
% resequenceImages(outputFile, inputFiles, 'raster', '420', 1024, 1024);
