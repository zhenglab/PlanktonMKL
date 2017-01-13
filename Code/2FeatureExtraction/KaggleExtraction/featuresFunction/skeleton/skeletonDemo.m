% read in a sample image -- also see letters.png, bagel.png
function skelArea = skeletonDemo(imgBinary)
img = imgBinary;% imread('jb19700101_1_35.png');

% in more detail:
[skr,rad] = skeleton(img);

% thresholding the skeleton can return skeletons of thickness 2,
% so the call to bwmorph completes the thinning to single-pixel width.
skel = bwmorph(skr > 35,'skel',inf);
skelArea = sum(sum(skel));
% figure(4);imshow(skel)
