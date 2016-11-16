function [ scores ] = filter_allfeatures( allfeat, W, B, h, w )
% filters all features map in the dataset allfeat.
%
% input: allfeat: 2D cell array of feature maps
%        W,B: filter and offset
%        h,w: height and width of the filters
%
% output: scores: the filtered output

ntr = size(allfeat,1); % number of transformations in image pyramid
nim = size(allfeat,2); % number of images

scores = cell(ntr,nim);
% filter all hog blocks in dataset
for j = 1:nim
    for i = 1:ntr
        tmp = filter_features(allfeat{i,j},W,B,h,w);
        s = size(tmp);
        scores{i,j} = reshape( tmp, [s(1)*s(2), size(B,2)] )';
    end
end
scores = cat(2,scores{:});

end
