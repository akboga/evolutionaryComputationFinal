function security_cam
clear;
close all; 
clc;
imaqreset;

%% Setup image Acquisition
hCamera = webcam;
% Create a handle to an imshow figure for faster updating
hShow = imshow(zeros(1080, 1920, 3, 'uint8')); title('Security Cam');

%% Acquire reference image.
ref_vid_img = snapshot(hCamera);

%% Quantize images and outputing the screen with DE parameters. 

frames = 10000;
for i = 1 : frames
    % Acquire an image from webcam 
    vid_img = snapshot(hCamera);
    % Call the live segmentation function
    object_detected = Segmentation_fn(vid_img, ref_vid_img);
    % Update the imshow handle with a new image
    set(hShow,'CData',object_detected);
    drawnow;
end

%%