function [ scores ] = filter_features( feat, W, B, h, w )
% filters a feature map.
%
% input: feat: feature map
%        W,B: each column is W(:,i) and B(:,i) is a filter and offset. The
%             size(W,1) = h*w*v, where v = size(feat,3)
%        h,w: height and width of filter
%
% output: scores: filtered image

% fix for small images
if size(feat,1)-h+1 < 1 || size(feat,2)-w+1 < 1
    scores = [];
    return;
end

v = size(feat,3); nf = size(B,2);
scores = cell(1,nf);
for i = 1:nf
    scores{i} = convn( feat, reshape( flip(W(:,i),1), [h w v] ), 'valid' ) + B(i);
end
scores = cat(3,scores{:});

end