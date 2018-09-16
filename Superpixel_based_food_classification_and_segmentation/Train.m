% train random forest
% Use the first 2 images in the full diet 1 to train a random forest model
% Requires a random forest package which can be downloaded at
%
clc,clear,close all;
Train_feature_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Features\';
Train_label_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Labels\';

Num_case = 2;

Labels = [];
Features = [];

for i = 1:Num_case
    F = importdata(strcat(Train_feature_path,'F',num2str(i),'.mat'));
    Features = cat(1,Features,F);
    L = importdata(strcat(Train_label_path,'L',num2str(i),'.mat'));
    Labels = cat(1,Labels,L);
    
    
end
Features = Features(Labels>0,:);
Labels = Labels(Labels>0);
Features(isnan(Features)) = 0;
model = classRF_train(Features,Labels, 1000,30);