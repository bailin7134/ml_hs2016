function [ft] = framewarp(f,A)
% Affinely transforms the frames. The coordinates will go to the exact same
% place, where the image point would go on a warped image, using
% [imt,Af] = my_imwarp( im, A ).
%
% input: f: frames on the original image im
%        A: 3*3 affine transformation matrix (it has to be fixed with
%           fixaffine2d)
%
% output: ft: frames on the warped image

n = size(f,2);
ft = zeros(6,n);

% position to the proper place
ft(1:2,:) = A(1:2,1:2) * f(1:2,:) + repmat(A(1:2,3),[1, n]);

% fix orientation, and affine distortion
ft(3,:) = A(1,1:2) * f([3 4],:);
ft(4,:) = A(2,1:2) * f([3 4],:);
ft(5,:) = A(1,1:2) * f([5 6],:);
ft(6,:) = A(2,1:2) * f([5 6],:);

end
