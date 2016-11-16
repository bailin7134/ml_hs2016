function [d] = u2block(feat,u,h,w)
% Extracts a block from a feature map.
%
% input: feat: feature map
%        u: the top left corners of the feature blocks. u = [htop;wleft]
%        h,w: height and width of blocks to be extracted
%
% output: d: h*w*v: the extracted feature block

d = feat( u(1):u(1)+h-1, u(2):u(2)+w-1, : );

end

