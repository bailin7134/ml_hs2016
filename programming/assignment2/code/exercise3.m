
% setup
addpath(genpath('./'));

% feature parameters
cellSize = 4; h = 6; w = 6; % tamplate sizes, height and width

% select feature extractor
% featureExtractor = @(x) pixels( single(x)/256, cellSize );
featureExtractor = @(x) hog( single(x)/256, cellSize );
init;

% pegasos
posratio = 0.01;
lambda = 0.0001;
T = 32 * 2^10; % number of iterations
K = 128; % mini-batch size
train_svm;

evaluate;
