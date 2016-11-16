
% set stuff for pegasos
[ tridx, imidx, u ] = allfeatures2indices( featntrain, h, w );
xnrender = @(idx) allfeatures2blocks( featntrain, ...
                                      tridx(:,idx), ...
                                      imidx(:,idx), ...
                                      u(:,idx), h, w );
idxmax = size(u,2);

% train classifier
fprintf('train (with pegasos) ... ');
tic;
[W,B] = pegasos( xptrain, xnrender, idxmax, posratio, lambda, T, K );
toc;
