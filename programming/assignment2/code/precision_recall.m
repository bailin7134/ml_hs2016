function [ rec, prec, ap ] = precision_recall( labels, scores )

n = size(labels,2);

[~,idx] = sort(scores,'descend');
positives = labels(idx) > 0;

rec = ( 0:sum(positives) ) / sum(positives);

prec = cumsum( positives ) ./ (1:n);
[~,IA,~] = unique( [cumsum( positives ), 0] );
prec = [1 prec(IA(2:end))];

ap = sum(prec(2:end)) / sum(positives);

end
