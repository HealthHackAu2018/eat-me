function [Features] = Feature_extraction(image, ROI)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
image_HSV = rgb2hsv(image);
%% RGB space intensity

% mean R
R_channel = image(:,:,1);
mean_R = intensity_features(R_channel, ROI);% mean(R_channel(ROI>0));

% mean G
G_channel = image(:,:,2);
mean_G = intensity_features(G_channel, ROI);

% mean B
B_channel = image(:,:,3);
mean_B = intensity_features(B_channel, ROI);

%% HSV  space intensity

% mean H
H_channel = image_HSV(:,:,1);
mean_H = intensity_features(H_channel, ROI);

% mean S
S_channel = image_HSV(:,:,2);
mean_S = intensity_features(S_channel, ROI);

% mean V
V_channel = image_HSV(:,:,3);
mean_V = intensity_features(V_channel, ROI);



%% texture feature
expand = imdilate(ROI,strel('disk',5));
[GLCM_H] = perform_GLCM(H_channel,expand);
[GLCM_S] = perform_GLCM(S_channel,expand);
[GLCM_V] = perform_GLCM(V_channel,expand);

%% Contrast
[CF_H] = Contrast(H_channel,ROI,10);
[CF_S] = Contrast(S_channel,ROI,10);
[CF_V] = Contrast(V_channel,ROI,10);


Features = [mean_R mean_G mean_B mean_H mean_S mean_V ...
   GLCM_H  GLCM_S GLCM_V CF_H CF_S CF_V];

end

