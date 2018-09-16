function [F] = intensity_features(im, ROI)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
im = double(im);
intensity = im(ROI>0); 
mean_f = mean(intensity);
std_f = std(intensity);

F = [mean_f,std_f];
end

