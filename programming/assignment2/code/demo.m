
% select image
path = '../data/demo';
names = path2imagenames( path );
impath = names{3};

% load image
im = imresize( imread(impath), [480,nan] );

% image pyramid parameters
octaveResolution = 8;
scales = 2 .^ (-3:1/octaveResolution:0);
A = scale2matrix( scales );

% extract features
[ feat, Af ] = image2pyramid( im2single(rgb2gray(im)), A, featureExtractor );

% best responses
thresh = 0.5;

nsc = size(A,3);
scores = cell(nsc,1); bbox = cell(nsc,1);
for i = 1:nsc
    % filter features
    si = filter_features( feat{i}, W, B, h, w );
    if numel(si) == 0
        bbox{i} = zeros(4,0); scores{i} = zeros(1,0);
    end
    % sort best responses
    [si,I] = sort(si(:)', 'descend');
    si = si( :, 1:sum(si>=thresh) );
    scores{i} = si;
    % get bboxes
    u = feat2u( size(feat{i}), h, w );
    u = u( :, I(1:sum(si>=thresh)) );
    bi = u2bbox( u, h, w, cellSize, [0.5;0.5] );
    bbox{i} = frame2bbox( framewarp( bbox2frame(bi), inv(Af(:,:,i)) ) );
end
bbox = cat(2,bbox{:});
scores = cat(2,scores{:});
[scores,I] = sort(scores, 'descend');
bbox = bbox(:,I);

% bounding box supression
overlap = 0.3;
[ bbox, good ] = bboxsupress( bbox, overlap );
scores = scores(:,good);
M = min( 50, size(bbox,2) );
bbox = bbox(:,1:M);

% show results
figure(1); clf;
imshow(im); hold on;
plotbox( bbox );


