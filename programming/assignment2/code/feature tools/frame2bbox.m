function [ b ] = frame2bbox( f )
% The coordinates of input frames are the midlle of the bounding boxes.
% The boundaries of their ellipsoids touch the bounding boxes.
%
% input: f: each column is a frames (6 dimensional, vl_feat standard)
%
% output: b: each column is a bounding box

rx = sqrt(f(3,:).^2 + f(5,:).^2);
ry = sqrt(f(4,:).^2 + f(6,:).^2);
b = [ f(1,:)-rx; f(2,:)-ry; f(1,:)+rx; f(2,:)+ry];

end
