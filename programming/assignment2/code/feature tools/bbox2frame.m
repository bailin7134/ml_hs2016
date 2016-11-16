function [ f ] = bbox2frame( b )
% The coordinates of output frames are the midlle of the bounding boxes.
% Their orientation is upright and their sizes match, so boundaries of
% ellipsoids touch the bounding boxes.
%
% input: b: each column is a bounding box
%
% output: f: each column is a frames (6 dimensional, vl_feat standard)

f = zeros(6,size(b,2));
f(1,:) = ( b(3,:) + b(1,:) ) / 2;
f(2,:) = ( b(4,:) + b(2,:) ) / 2;
f(3,:) = ( b(3,:) - b(1,:) ) / 2;
f(6,:) = ( b(4,:) - b(2,:) ) / 2;

end

