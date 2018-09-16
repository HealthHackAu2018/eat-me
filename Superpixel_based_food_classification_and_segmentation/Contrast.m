function [F] = Contrast(im,ROI,D)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
S = strel('disk',D);
background = imdilate(ROI,S)-ROI;
im = double(im);
in_b = mean(im(background>0));
std_b = std(im(background>0));
C = mean(im(ROI>0))/mean(im(background>0));

F = [in_b,std_b,C];
end

