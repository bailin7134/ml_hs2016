function [ tridx, imidx, u ] = allfeatures2indices( allfeat, h, w )
% Creates the indices for all blocks in the feature dataset
%
% input: allfeat: the feature dataset
%        h,w: height and width of blocks
%
% output: tridx: transformation index (select scale in image pyramid)
%         imidx: image idx (selects the image)
%         u: the columns are the top left corners of the feature blocks.
%            u(:,i) = [htop;wleft];

ntr = size(allfeat,1);
nim = size(allfeat,2);

tridx = cell(ntr,nim);
imidx = cell(ntr,nim);
u = cell(ntr,nim);
% process all hog blocks in dataset
for j = 1:nim
    for i = 1:ntr
        % hog block coordinates
        u{i,j} = feat2u( size(allfeat{i,j}), h, w );
        % transformation index
        tridx{i,j} = i*ones(1, size(u{i,j},2) );
        % image index
        imidx{i,j} = j*ones(1, size(u{i,j},2) );
    end
end
tridx = cat(2,tridx{:});
imidx = cat(2,imidx{:});
u = cat(2,u{:});

end