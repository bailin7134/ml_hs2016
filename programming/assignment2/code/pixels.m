function [ feat ] = pixels( im, cs )
%
% input: im: image
%        cs: cell size
%
% output: feat: feature representation, the same image pixels, but it is
%               rearranged in a way that fits the sliding window approach

s = floor( size(im) / cs );
if s(1) < 1 || s(2) < 1
    feat = zeros( [0,0,cellSize] );
    return;
end
tmp = im2col( im(1:s(1)*cs,1:s(2)*cs), [cs,cs], 'distinct' );
feat = reshape( tmp', [s(1), s(2), cs^2] );

end
