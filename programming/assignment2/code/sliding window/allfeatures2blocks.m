function [ d ] = allfeatures2blocks( allfeat, tr, im, u, h, w )
% Extracts feature blocks from feature dataset.
%
% input: allfeat: feature dataset
%        tr,im,u: transformation, image and block indices
%        h,w: height and width of blocks to be extracted
%
% output: d: extracted feature blocks, each column is a feature block

n = size(tr,2);
v = size(allfeat{1,1},3);
d = zeros( h*w*v, n );

% for all indices
for i = 1:n
    tmp = u2block( allfeat{tr(i),im(i)}, u(:,i), h, w );
    d(:,i) = tmp(:);
end

end
