function [ a ] = bbox2area( b )
% calculates the area of a bounding box. It is 0, if xmax <= xmin or ymax
% <= ymin
%
% input: b: the columns b(:,i) are the bounding boxes
%
% output: a: row vector, the values a(i) are the areas of b(:,i)

a = max(b(3,:)-b(1,:),0) .* max(b(4,:)-b(2,:),0);

end