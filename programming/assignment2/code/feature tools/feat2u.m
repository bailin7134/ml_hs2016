function [ u ] = feat2u( featsize, h, w )
% Extract the indices of blocks 
%
% input: featsize: size of feature map
%        h,w: heights, width of the blocks
%
% output: u: the columns are the top left corners of the feature blocks,
%            u(:,i) = [htop;wleft]. u(:,i) corresponds to d(:,i), where
%            d = feat2blocks(feat,h,w) and featsize = size(feat).

nh = featsize(1) - h + 1;
nw = featsize(2) - w + 1;
        
% hog block coordinates
wid = repmat( 1:nw, [nh 1]);
hid = repmat( (1:nh)', [1 nw]);
u = [ hid(:)'; wid(:)' ];

end

