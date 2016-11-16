function [ A ] = scale2matrix( scales )
% scale2matrix creates the transformation matrices on homogenous
% coordinates in 2D.
% 
% input: scales: the scales of transformations
%
% output: A: 3x3xN matrix, where N = numel(scales).

A = zeros(3,3,numel(scales));
A(1,1,:) = scales;
A(2,2,:) = scales;
A(3,3,:) = 1;

end

