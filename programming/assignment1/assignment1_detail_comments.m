
% "Data" contains our training examples. It is an Nx576 matrix. Each row
% represents one train example. The training examples are img_wthximg_hgt grayscale
% images represented as a 1ximg_wdt*img_hgt row vector. The range of possible values
% are from 0 to 255. The dataset contains the mirrored pair of every face
% in the dataset.
% "Labels" contain the labels of the training data. It is an 1xN matrix. If
% Labels(1,k) = 1, it means the kth sample is a face, if it is -1, than the
% sample is not a face. All the labels are either 1 or -1.

clear all;
% Choose the dataset from {faces, pedestrians}
db_name = 'faces';

% Choose the method from {sgd, newton, gda}
method = 'sgd';

if( strcmp(db_name, 'faces') == 1 )
    img_wth = 24;
    img_hgt = 24;
    load('faces.mat');
elseif(strcmp(db_name, 'pedestrians') == 1 )
        img_wth = 24;
        img_hgt = 24;
        load('pedestrians.mat');
else
    disp('ERROR: Datset names must be "faces" or "pedestrians"!' );
    return;
end

Data = single(Data'); % column vectors are the samples
% change data into single precision

% Display some examples images from the database.
figure(1); clf;
n = 6;
N = size(Data,2);
for k = 1:n % first row: faces
    im = reshape(Data(:,k), [img_hgt img_wth]);
    subplot(2,n,k);
    imshow( im/256 );
end
for k = 1:n % second row: non-faces
    im = reshape(Data(:,k+N/2), [img_hgt img_wth]);
    subplot(2,n,k+n);
    imshow( im/256 );
end

% Divide the data into train and test set

train = rand(1,N) < 0.7; % 70% train examples
% generate random values between 0 and 1
% comparing with 0.7, if smaller return 1, or return 0
dim = size(Data,1);
% get the row number of matrix Data
ytrain = Labels(:,train);
% pick up the chosen labels by "train", which is array of logical values
ytest = Labels(:,~train);
% pick up the opposite lables, not chosen by "train"

% Logistic Regression
x = [ Data/256; ones(1,N) ]; % normalize and add intercept term
xtrain = x(:,train);


fprintf('training ... ');
tic;
switch method 
    case 'sgd'
        theta = logistic_sgd( xtrain, single(ytrain > 0) );
        W = theta(1:dim)/256; B = theta(dim+1); % denormalize
    case 'newton'
        theta = logistic_newton( xtrain, single(ytrain > 0) );
        W = theta(1:dim)/256; B = theta(dim+1); % denormalize
    case 'gda'
        xtrain = Data(:,train)/256; % normalize data
        % [ phi, mu0, mu1, Sigma ] = gda_dummy( xtrain, ytrain );
        [ phi, mu0, mu1, Sigma ] = gda( xtrain, ytrain );
        [U,D,~] = svd(Sigma);
        Sinv = U*diag(1./diag(D))*U'; % numerically more stable inversion
        W = Sinv*(mu1-mu0);
        B = - 0.5*mu1'*Sinv*mu1 + 0.5*mu0'*Sinv*mu0 + log(phi) - log(1-phi);
        W = W/256; % denormalize
end
toc;


% Test classifier
scores = W'*Data(:,~train) + B;
threshold = 0.5;
output = (scores >= threshold) - (scores < threshold);

% Accuracy
Ntest = size(ytest,2);
good = output == ytest;
fprintf( 'accuracy: %f (%d/%d)\n', sum(good)/Ntest, sum(good), Ntest );

% The metrics of evaluations (ROC and precision-recall curve) are described
% on Wikipedia:
%     http://en.wikipedia.org/wiki/Precision_and_recall
%     http://en.wikipedia.org/wiki/Receiver_operating_characteristic
[~,idx] = sort(scores,'descend');
sorted_ytest = ytest(idx);
positives = sorted_ytest > 0;

% Precision-Recall curve
precision = cumsum( positives ) ./ (1:Ntest);
recall = cumsum( positives ) / sum( positives );
figure(2); clf;
plot(recall,precision);
axis( [0 1 0 1] );
title('precision-recall curve');
xlabel('Recall');
ylabel('Precision');

% ROC curve
truepos = cumsum( positives ) / sum( positives ); % same as recall
falsepos = cumsum( ~positives ) / sum( ~positives );
figure(3); clf;
plot(falsepos,truepos);
axis( [0 1 0 1] );
title('ROC curve');
xlabel('False Positive Rate');
ylabel('True Positive Rate');

% display score histograms
[g1,n1] = hist(scores(ytest>0),50);
[g2,n2] = hist(scores(ytest<0),50);
g1 = g1 * sum(g2) / sum(g1);
figure(4); clf;
bar(n1,g1,'r');
hold on;
bar(n2,g2,'b');
title('Histogram of scores');

% display some classifications
figure(5); clf;
n = 6;
test = find(~train);
faceidx = test(output>0);
faceidx = faceidx(:,randperm(size(faceidx,2)));
nonfaceidx = test(output<0);
nonfaceidx = nonfaceidx(:,randperm(size(nonfaceidx,2)));
for k = 1:n % classifies as face
    im = reshape(Data(:,faceidx(k)), [img_hgt img_wth]);
    subplot(2,n,k);
    imshow( im/256 );
end
for k = 1:n % classifies as non-face
    im = reshape(Data(:,nonfaceidx(k)), [img_hgt img_wth]);
    subplot(2,n,k+n);
    imshow( im/256 );
end
