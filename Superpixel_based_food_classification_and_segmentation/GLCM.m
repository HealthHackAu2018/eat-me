function [ glcms ] = GLCM( img, direction, level_num )
%GLCM Summary of this function goes here
%   Detailed explanation goes here
% This is a fuction calculating the 4 direction GLCM of the input image

%  INPUT      img   The input image
%             direction   The glcm direction
%       
%                    -----     ------
%                    0         [0 D]
%                    45        [-D D]
%                    90        [-D 0]
%                    135       [-D -D]
%             level_num   The number of graylevel
%  OUTPUT     glcm        GLCM properties, including contrast, correlation, energy, homogeneity

% Initialize the GLCM property struct
glcms = struct ('horizontal',[],'vertical',[],'angle45',[],'angle135',[]);
%% Horizontal
if strcmp (direction,'horizontal')|| strcmp (direction,'all')
    [glcm] = graycomatrix (img, 'GrayLimits',[],'offset',[0,1],'NumLevels',level_num);%    
    props = graycoprops(glcm, 'all');% 
    glcms.horizontal = cell2mat(struct2cell(props)');%   
end
%% Vertical
if strcmp (direction,'vertical')|| strcmp (direction,'all')
    [glcm] = graycomatrix (img, 'GrayLimits',[],'offset',[-1,0],'NumLevels',level_num);    
    props = graycoprops(glcm, 'all');
    glcms.vertical = cell2mat(struct2cell(props)');    
end
%% 45 degree
if strcmp (direction,'angle45')|| strcmp (direction,'all')
    glcm = graycomatrix (img, 'GrayLimits',[],'offset',[-1,1],'NumLevels',level_num);%
    props = graycoprops(glcm, 'all');       
    glcms.angle45 = cell2mat(struct2cell(props)');%    
end
%% 135 degree
if strcmp (direction,'angle135')|| strcmp (direction,'all')
    glcm = graycomatrix (img, 'GrayLimits',[],'offset',[-1,-1],'NumLevels',level_num);%    
    props = graycoprops(glcm, 'all');    
    glcms.angle135 = cell2mat(struct2cell(props)');%    
end

end

