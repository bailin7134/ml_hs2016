
% load face dataset
load('../data/faces.mat');

% positive samples
fprintf('extract features (face dataset) ... ');
tic;
x = cell(1,size(Data,1));
for k = 1:size(Data,1)
    im = reshape( Data(k,:), [24 24] );
    feat = featureExtractor(im);
    v = size(feat,3);
    x{k} = feat(:);
end
x = cat(2,x{:});
toc;

% get positive samples and discaard negatives
xp = x(:,Labels>0);
ratio = 0.7;
n = size(xp,2); perm = randperm(n); n1 = round(n*ratio);
xptrain = xp(:,perm(1:n1));
xptest = xp(:,perm(n1+1:n));

% transformations for negative images
octaveResolution = 5;
scales = 2 .^ (-3:1/octaveResolution:0);
A = scale2matrix( scales );
preprocess = @(im) imresize( rgb2gray(im), [480, nan] );

% negatives
tic;
fprintf('extract features (negatives, train, face dataset) ');
namesNegTrain = path2imagenames( '../data/negatives train' );
[ featntrain, ~ ] = names2allfeatures(namesNegTrain,A,featureExtractor,preprocess);
fprintf(' ');
toc;

tic;
fprintf('extract features (negatives, test, face dataset) ');
namesNegTest = path2imagenames( '../data/negatives test' );
[ featntest, ~ ] = names2allfeatures(namesNegTest,A,featureExtractor,preprocess);
fprintf(' ');
toc;
