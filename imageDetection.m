%% Reading images from Current Folder.
img1 = imread('testImage1.jpg');
img2 = imread('testImage2.jpg');

%% Displaying original images.
figure
imshow(img1)
figure
imshow(img2)

%% Converting images Black-White.
img1BW = rgb2gray(img1);
img2BW = rgb2gray(img2);

%% Displaying Black-White images.
figure
imshow(img1BW)
figure
imshow(img2BW)

%% Subtract images.
imgDiff = abs(img1BW-img2BW);
figure
imshow(imgDiff)

%% Find maximum location of difference.
maxDiff = max(max(imgDiff));
[iRow,iCol] = find(imgDiff == maxDiff);
[m,n] = size(imgDiff);
imshow(imgDiff)
hold on
plot(iCol,iRow,'*r')

%% Use imtool to determine threshold and length.
imtool(imgDiff)

%% DE PARAMETERS (1)
%Threshold image.
imgThreshold = imgDiff > 8;
figure
imshow(imgThreshold)
hold on
plot(iCol,iRow,'*r')
hold off

%% Fill in regions.
imgFill = bwareaopen(imgThreshold,15);
figure
imshow(imgFill)

%% Overlay onto original images.
imgBoth = imoverlay(img2,imgFill,[1 0 0]);
figure
imshow(imgBoth)

%% DE PARAMETERS (2)
%Only care about things large than 80.
imgStats = regionprops(imgFill, 'MajorAxisLength');
imgLength = [imgStats.MajorAxisLength];
idx = imgLength > 80;
imgStatsFinal = imgStats(idx);
disp(imgStatsFinal)

%% Determine if change is significant and warn user.
if isempty(imgStatsFinal)
    disp('Nothing different here.')
else
    disp('Something is here!');
end

% %---------------------------------------------------------------------------%
% THIS PART IS EXTRA FOR NORMAL VIDEO IMPLEMENTATIONS
% peopleDetector = vision.PeopleDetector;
% video = vision.VideoFileReader('trainStation.avi');
% viewer = vision.VideoPlayer;
% while ~isDone(video)
%     image = step(video);
%     [bboxes, scores] = step(peopleDetector,image);
%     I_people = insertObjectAnnotation(image,'rectangle',bboxes,scores);
%     step(viewer,I_people);
% end