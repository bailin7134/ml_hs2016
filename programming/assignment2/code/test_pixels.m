
cs = 7; n = 13; m = 28;
im = rand(cs*n,cs*m);

feat = pixels(im,cs);

err = 0;
for i = 1:n
    for j = 1:m
        tmp = im( (i-1)*cs+(1:cs), (j-1)*cs+(1:cs) );
        errij = max(abs( tmp(:) - reshape(feat(i,j,:), [cs^2 1]) ));
        err = err + errij;
    end
end

err
