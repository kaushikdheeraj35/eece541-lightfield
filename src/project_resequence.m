%% EECE 541 Light Field Project
% Resequence videos to spiral for subjective tests

inputFile = '../assets/sequence_line_420.yuv';
outputFile = '../assets/sequence_spiral_420.yuv';
resequenceImages(outputFile, inputFile, 'line', 1024, 1024);

inputFiles = [
    '../assets/mvc/mvc_420_0.yuv ';
    '../assets/mvc/mvc_420_1.yuv ';
    '../assets/mvc/mvc_420_2.yuv ';
    '../assets/mvc/mvc_420_3.yuv ';
    '../assets/mvc/mvc_420_4.yuv ';
    '../assets/mvc/mvc_420_5.yuv ';
    '../assets/mvc/mvc_420_6.yuv ';
    '../assets/mvc/mvc_420_7.yuv ';
    '../assets/mvc/mvc_420_8.yuv ';
    '../assets/mvc/mvc_420_9.yuv ';
    '../assets/mvc/mvc_420_10.yuv';
    '../assets/mvc/mvc_420_11.yuv';
    '../assets/mvc/mvc_420_12.yuv';
    '../assets/mvc/mvc_420_13.yuv';
    '../assets/mvc/mvc_420_14.yuv';
    '../assets/mvc/mvc_420_15.yuv';
    '../assets/mvc/mvc_420_16.yuv';
];
outputFile = '../assets/mvc_420_spiral.yuv';
resequenceImages(outputFile, inputFiles, 'line', 1024, 1024);
