function [b] = u2bbox( u, h, w, stride, offset )
% This function computes the bounding boxes belonging to the feature blocks
% on a feature map.
%
% input: u: the top left corners of the feature blocks. u = [htop;wleft]
%        h,w: height and width of blocks to be extracted
%        stride: the number of picels between the gridpoints on the feature
%                map. For the HOG features it is the cellsize.
%        offset: [xmin;ymin] this is the top left corner of the bounding
%                box computed from u = [1;1]. This is [0.5;0.5] for the HOG
%                features. It is interpreted as an image coordinate
%
% output: b: bounding box [wmin;hmin;wmax;hmax] in image coordinates

bint = [ u; bsxfun(@plus, u, [h;w]) ];
b = bsxfun( @plus, (bint([2,1,4,3],:)-1)*stride, offset([1,2,1,2],:) );

end
