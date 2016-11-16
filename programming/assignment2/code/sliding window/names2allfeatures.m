function [feat, Af] = names2allfeatures(names,A,featextractor,preprocess)
% Extracts features on an image pyramid from image dataset.
%
% input: names: cell list of image paths
%        A: 3x3xN matrices (affine transformations)
%        featextractor: a function that extract features on a grid from
%                          grayscale images(like HOG)
%        preprocess: the input images are preprocessed according to this
%                    function
%
% output: feat: 2D cell array of extracted features (transformations and
%               images)

m = size(A,3);
n = numel(names);

dispIter = false(1,n);
dispIter( max( round((1:10)*n/10), 1 ) ) = true;

% extract features
Af = cell( 1, n );
feat = cell( m, n );
for j = 1:n
    % display progress
    if dispIter(j)
        fprintf('.');
    end
    % load image and preprocess
    im = imread( names{j} );
    im = preprocess(im);
    % extract features in image pyramid
    [ feat(:,j), Af{j} ] = image2pyramid( im, A, featextractor );
end

end

