%%Name= Rutvij Dhotey
%Homework 1

%%Code for finding the constants

%%First Step
%1.Accept the input from the figure and format it for a nX2 matrix f(x,w)

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

%making an array for the F(x,w)
%here x=Ymax= Row of the boxes
%here H= Height of the box

F= [Ymax , H];
N= size(F,1);
xi=0;
wi=0;
xi2=0;
wixi=0;

%2. calculating Summations

for i=1:N
    xi= xi+ Ymax(i);
    xi2= xi2+ Ymax(i)^2;
    wi= wi+ H(i);
    wixi= wixi + Ymax(i)*H(i);
end


a=[N xi; xi xi2];
b=[wi ; wixi];

%3. solving the linear equations for Phi1 and Phi0
P=linsolve(a,b);

sum=0;

%4. solving for Variance

for i=1:N
    sum= sum + ( H(i)- (P(1) + P(2)*Ymax(i)))^2;
end
    var= sum/N;
    
    sigma= sqrt(var);
    
    





