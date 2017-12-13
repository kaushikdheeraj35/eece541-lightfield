%% EECE 541 Light Field Project
% Resequence videos to spiral for subjective tests

inputFile = '../assets/sequence_line_420.yuv';
outputFile = '../assets/sequence_spiral_420.yuv';
resequenceImages(outputFile, inputFile, 1024, 1024);
