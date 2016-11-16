function [ feat, Af ] = image2pyramid( im, A, featextractor )
% Extracts features from transformed images.
%
% input: im: image
%        A: 3x3xN affine transformation matrices
%        featextractor: a function for feature extraction. It's form is
%                       f = featextractor(im).
%
% output: Af: 3x3xN the fixed affine transformation matrices

n = size(A,3);
feat = cell(n,1);
Af = A;
for i=1:n
    % transform images
    [ imt, Af(:,:,i) ] = affinewarp( im, A(:,:,i) );
    % extract features
    feat{i} = featextractor(imt);
end

end

