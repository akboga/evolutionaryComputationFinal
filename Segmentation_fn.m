function [highlighted_img] = Segmentation_fn(img1,img2)
%% Convert images black and white.
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

%% Display black and white images.
%figure, imshow(imgBW1);
%figure, imshow(imgBW2);

%% Subtract images
imgDiff = abs(imgBW1-imgBW2);
%figure, imshow(imgDiff);

%% Find maximum location of difference
maxDiff = max(max(imgDiff));
[iRow,iCol] = find(imgDiff == maxDiff);
[m,n] = size(imgDiff);
% imshow(imgDiff)
% hold on
% plot(iCol,iRow,'r*')

%% Use imtool to determine threshold and length
% imtool(imgDiff)

%% Threshold image
imgThresh = imgDiff > 8;
% figure
% imshow(imgThresh)
% hold on
% plot(iCol,iRow,'r*')
% hold off
%% Fill in regions 
imgFilled = bwareaopen(imgThresh,15);
% figure, imshow(imgFilled);

%% Overlay onto original image
imgBoth = imoverlay(img2,imgFilled, [1,0,0]);
% figure, imshow(imgBoth)
highlighted_img = imgBoth;

%% Only care about things large than 80.
imgStats = regionprops(imgFilled, 'MajorAxisLength');
imgLength = [imgStats.MajorAxisLength];
idx = imgLength > 80;
imgStatsFinal = imgStats(idx);
%disp(imgStatsFinal)

%% Determine if change is significant.
if isempty(imgStatsFinal)
    disp('Nothing different here.')
else
    disp('Something is here!');
   
end

%%
