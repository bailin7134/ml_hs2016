function [ ] = plotbox( bb )

for i = 1:size(bb,2)
    plot( bb([ 1 3 3 1 1],i), bb([ 2 2 4 4 2],i), 'y', 'LineWidth', 2 );
end

end

