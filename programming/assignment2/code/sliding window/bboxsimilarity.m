function [ s ] = bboxsimilarity( b1, b2 )
% input: b1, b2: bounding boxes
%
% output: s: s(i,j) is the similarity between the bounding boxes b1(:,i)
%            and b(:,j). The similarity meassure is the voc standard area
%            of intersection divided by the area of union.

xmin = bsxfun( @max, b1(1,:)', b2(1,:) );
ymin = bsxfun( @max, b1(2,:)', b2(2,:) );
xmax = bsxfun( @min, b1(3,:)', b2(3,:) );
ymax = bsxfun( @min, b1(4,:)', b2(4,:) );

areaint = max( xmax-xmin, 0 ) .* max( ymax-ymin, 0 );
areauni = bsxfun( @plus, bbox2area(b1)', bbox2area(b2) ) - areaint;
s = areaint ./ areauni;

end
