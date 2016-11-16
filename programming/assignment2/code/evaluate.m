
% evaluate classifier
tic;
fprintf('evaluate classifier ... ');
% test set
scoresP = W' * xptest + B;
scoresN = filter_allfeatures( featntest, W, B, h, w );

% train set
% scoresP = W' * xptrain + B;
% scoresN = filter_allfeatures( featntrain, W, B, h, w );

scores = [ scoresP, scoresN ];
labels = [ ones(1,size(scoresP,2)), -ones(1,size(scoresN,2)) ];
[ rec, prec, ap ] = precision_recall( labels, scores );
toc;

% show PR curve
figure;
plot(rec,prec);
title('PR curve');

% show histograms of scores
[g1,n1] = hist(scoresP,50);
[g2,n2] = hist(scoresN,50);
g1 = g1 * sum(g2) / sum(g1);
figure;
bar(n1,g1,'r');
hold on;
bar(n2,g2,'b');
title('histogram of scores');

% show average precision
fprintf('average precision: %f\n', ap);

