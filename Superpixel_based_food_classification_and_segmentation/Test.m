% Testing on Full diet 1 3rd and 4th images
clc,clear,close all;
feature_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Features\';
label_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Labels\';
Model_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Model\RF_model.mat';

image_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Images\Images\';
% binary_label_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Images\Labels\Label\';% ground truth label
[ item_name ] = Read_files_in_folder( image_path );

RF = importdata(Model_path);
Num_case = 2;

for i = 3:length(item_name)-1
    disp(item_name{i});
    image = imread(strcat(image_path,item_name{i}));
    image = imresize(image,0.5);
    Foreground = image(:,:,1)>0;
    Foreground = imerode(Foreground,strel('disk',3));
    figure,imshow(image);
    [L,N] = superpixels(image,500);
    figure
    BW = boundarymask(L);
    imshow(imoverlay(image,BW,'cyan'),'InitialMagnification',67);
    
    index = L(Foreground>0);
    index = sort(unique(index));
    
    Labels = importdata(strcat(label_path,'L',num2str(i),'.mat'));
    Features = importdata(strcat(feature_path,'F',num2str(i),'.mat'));
    Features(isnan(Features)) = 0;
    Y_hat = classRF_predict(Features,RF);
    fprintf('\nexample 1: error rate %f\n',   length(find(Y_hat~=Labels))/length(Labels));
    
    figure, hold on;
    colors = {'r','g','b','c','m'};
    
%     canvas = image;
    canvas = zeros(size(BW));
    individual = {canvas,canvas,canvas,canvas};
    LL = 5;
    for l = 1:length(index)% rois
        
        ROI =( L==index(l));

        
        M = boundarymask(ROI);
        if Y_hat(l)<5
        canvas = imoverlay(canvas,ROI,colors{Y_hat(l)});
        individual{Y_hat(l)}(ROI)=1;
        end
        
        
        
    end
    imshow(canvas);
end