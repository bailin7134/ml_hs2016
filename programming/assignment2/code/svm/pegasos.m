function [ W, B ] = pegasos( xp, xnrender, idxmax, posratio, lambda, T, K )
% This is the implementation of the pegasos algorithm for learning linear
% SVM.
%
% This is simply a stochastic gradient method with some modifications:
% 1) The objective function is not differentiable, but you can still use
%    subgradient instead of gradient. The subgradient of abs(x) is sign(x).
%    This is a generalization of the gradient. If the gradient exists, the
%    subgradient is the same.
% 2) The learning rate is set to decrease at a rate 1/t during the iterations
%    1:T.
% 3) Mini batches. Not one, but K samples are used to approximate the
%    (sub)gradient.
%
% input: xp: dim*np matrix, positive samples
%        xnrender: function xn = xnrender(idx), is a function that renders
%                  negative examples.
%        idxmax: the valid indices for xnrender is between 1 and idxmax
%        posratio: ratio of positive samples
%        lambda: SVM parameter
%        T: number of iterations (pegasos paramter)
%        K: mini-batch size (pegasos paramter)
%
% output: W,B: parameters of linear SVM classifier

% init
[ dim, np ] = size(xp);
W = zeros(dim,1); B = 0;

% iterate
for t = 1:T
    % select number of positives and negatives in mini-batch
    kp = sum( rand(1,K) <= posratio ); kn = K - kp;
    % select samples [ positives, negatives ]
    xt = [ xp( :, randi(np,[1,kp]) ), xnrender( randi(idxmax,[1,kn]) ) ];
    yt = [ones(1,kp),-ones(1,kn)];
    % At is the set of indices that y_i*(w'*x_i+b) < 1
    At = yt .* ( W'*xt + B ) < 1;
    % set mut
    mut = 1 / (lambda*t);
    % update W,B
    W = (1 - mut*lambda)*W + (mut/K) * sum( bsxfun( @times, At.*yt, xt ), 2 );
    B = (1 - mut*lambda)*B + (mut/K) * sum( At .* yt, 2 );
end

end

