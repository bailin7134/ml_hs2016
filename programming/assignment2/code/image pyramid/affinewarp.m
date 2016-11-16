function [ imw, Af ] = affinewarp( im, A )
% Warps the image affinely. It also fixes the Affine transformation matrix.
% We use the convention that the whole image coordinates represent the
% middle of the pixel of the corresponding intrinsic coordinate.
%
% input: im: image
%        A: 3x3 affine transformation matrix
%
% output: imw: warped image
%         Af: fixed 3x3 affine transformation matrix 

[imw,RB] = imwarp( im, imref2d(size(im),1,1), affine2d(A') );
Af = A;
Af(1:2,3) = A(1:2,3) - [ RB.XWorldLimits(1); RB.YWorldLimits(1) ] + 0.5;

end
