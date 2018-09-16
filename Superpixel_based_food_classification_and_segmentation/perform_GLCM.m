function [features] = perform_GLCM(IM,ROI)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
target = NaN(size(IM));
target (ROI ==1) = IM (ROI ==1) ;
[ glcms_target ] = GLCM( target, 'all', 8 );
features = [glcms_target.horizontal,glcms_target.vertical,glcms_target.angle45,glcms_target.angle135];
end

