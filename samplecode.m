%sample code for extracting bounding box information from the
%ground truth files distributed with the MOTchallenge datasets.

%choose one of the training datasets.  Choices are:
%ls 2DMOT2015Labels/train/
%ADL-Rundle-6	ETH-Pedcross2	KITTI-17	TUD-Stadtmitte
%ADL-Rundle-8	ETH-Sunnyday	PETS09-S2L1	Venice-2
%ETH-Bahnhof	KITTI-13	TUD-Campus

dataset = 'Venice-2';
dirstring = sprintf('2DMOT2015Labels/train/%s',dataset);

%load ground truth (gt), detections (det), and a sample frame (im)
load(sprintf('%s/gt/gt.txt',dirstring));
load(sprintf('%s/det/det.txt',dirstring));
im = imread(sprintf('%s/det/000001-acf.jpg',dirstring));

%parse bounding box info from ground truth
%W = width of bbox
%H = height of bbox
%Xi = x (column) location of upper left corner of bbox
%Yi = y (row) location of upper left corner of bbox
Nboxes = size(gt,1);
W = gt(:,5); H = gt(:,6); Xmin = gt(:,3); Ymin= gt(:,4);
Xmax = Xmin+W; Ymax = Ymin+H;

%draw a sampling of bboxes overlaid on the image
nsamples = 100;
sampleindices = randi(Nboxes,1,nsamples);
figure(1); imagesc(im); axis equal
hold on
for ii=1:nsamples
    i = sampleindices(ii);
    %plot bbox
    xvals = [Xmin(i) Xmax(i) Xmax(i) Xmin(i) Xmin(i)];
    yvals = [Ymin(i) Ymin(i) Ymax(i) Ymax(i) Ymin(i)];
    plot(xvals,yvals,'b-');
end
hold off
drawnow


phi= -514.77487 + 1.1148*Ymax;

phi1= -514.77487 + 2*11.513 + 1.1148*Ymax;

phi2= -514.77487 - 2*11.513 + 1.1148*Ymax;

%plot foot Y (row) location versus height
figure(2); plot(Ymax,H,'*', Ymax,phi,'*', Ymax,phi1,'*', Ymax,phi2,'*');





