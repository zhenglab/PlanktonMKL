clear all;
close all;
clc;

TrainingSetInfo = importdata('./zooscan/zooscan.txt');
TrainingSetNum = length(TrainingSetInfo.data);

for i = 1:TrainingSetNum
    img = imread(TrainingSetInfo.textdata{i, 1});
    
    [featureVector, filteredImages] = Gabor(img, 0.327, 6, 8, 0.5, 0.5, sqrt(2));
    
    featuresMatrixTrain(i,1:length(featureVector)) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./zooscan/zooscan-Train-Features-Gabor-Square.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);



% % %     imgBinaryLarge = zeros(imgX+4,imgY+4);
% % %     imgBinaryLarge(3:end-2,3:end-2) = imgBinary;
% % % %% 图像分割（去除噪声）
% % %     imgGraySeg = uint8(255-double(imgBinary).*double(255-img));%分割后的图像
% % % %% Gabor纹理
% % % imgGraySegResize = imresize(imgGraySeg,[256,256]);
% % % gaborArray = gaborFilterBank(5,8,39,39);%Gabor纹理
% % % featureVector = gaborFeatures(imgGraySegResize,gaborArray,4,4);
% % % % [coeff, score, latent, tsquared, explained] = pca(featureVector);