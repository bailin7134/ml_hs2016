function [ b2, good ] = bboxsupress( b, overlap )
% Non max supression of bounding boxes. We assume that the responses are
% ordered, so b(:,i) has highre response than b(:,i+1).

N = size(b,2);
if N == 0
    b2 = b; good = true(1,0);
    return;
end

good = true(1,N);
for i = 2:N
    if ~good(i-1)
        continue;
    end
    good(i:N) = good(i:N) & bboxsimilarity( b(:,i-1), b(:,i:N) ) <= overlap;
end
b2 = b(:,good);

end
