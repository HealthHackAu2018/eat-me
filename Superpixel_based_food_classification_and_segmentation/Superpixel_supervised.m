
% Apply superpixel on the plate image
% And label the superpixel samples
clc,clear,close all;
warning off;

image_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Images\Images\';% plate images
label_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Images\Labels\Label\';% Groundtruth of the different type of food
feature_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Features\';
label_save_path = 'C:\work\Healthhack\code\Superpixel_based_food_classification_and_segmentation\Labels\';
[ item_name ] = Read_files_in_folder( image_path );

for i = 1:length(item_name)-1%parfor
    disp(item_name{i});
    image = imread(strcat(image_path,item_name{i}));
    image = imresize(image,0.5);
    Foreground = image(:,:,1)>0;
    Foreground = imerode(Foreground,strel('disk',3));
%     figure,imshow(image);
    [L,N] = superpixels(image,500);
        figure
        BW = boundarymask(L);
        imshow(imoverlay(image,BW,'cyan'),'InitialMagnification',67);
    
    index = L(Foreground>0);
    index = sort(unique(index));
    %% feature extraction
%     All_samples = [];
%     for j = 1:length(index)
%         ROI =( L==index(j));
%         %         figure,imshow(ROI);
%         [F] = Feature_extraction(image, ROI);
%         
%         All_samples = cat(1,All_samples,F);
%     end
%     fname = strcat(feature_path,'F',num2str(i),'.mat');
%     parsave( fname, All_samples );
    
        %% Label the samples:  0 means mutral label backgroun label as 5
        All_labels  = zeros(length(index),1);
        L_path= strcat(label_path,num2str(i),'\');
        [ label_names ] = Read_files_in_folder( L_path );
        Label = [];
        LL = {};
        background = zeros(size(Foreground));
        % Label: 1:zuchini  2:potato  3: chicken, 4: chip
        types = {'zuchini','potato','chicken','chip'};
        for j = 1:length(label_names)
            disp(types{j});
            Label = cat(1,Label,str2num(label_names{j}(end-4))+1);
            IM = imread(strcat(L_path,label_names{j}));
            IM = imresize(IM,0.5);
            IM = (IM<10);
            LL = cat(1,LL,IM);
            background = double(IM)+background;
            % check the label image
            figure;
            bw = boundarymask(IM);
            imshow(imoverlay(image,bw,'b'),'InitialMagnification',67);
        end
        background = (background<1);
        LL = cat(1,LL,background);
    
        figure, hold on;
        colors = {'r','g','b','c','m'};
        canvas = image;
        for l = 1:length(index)% rois
            for ll = 1:length(LL)%labels
                label_mask = LL{ll};
                ROI =( L==index(l));
                overlap = length(find(ROI&label_mask))/length(find(ROI));
                if overlap >0.5
                    All_labels(l) = ll;
                    M = boundarymask(ROI);
                    canvas = imoverlay(canvas,ROI,colors{ll});
                end
    
            end
        end
    
        imshow(canvas);
    %% save label
    fname = strcat(label_save_path,'L',num2str(i),'.mat');
%     save(fname,'All_labels');
end
