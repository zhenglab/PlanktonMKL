close all;
clear all;
clc;

addpath(genpath('featuresFunction/'));

TrainingBinarySetInfo = importdata('./zooscan/zooscanBinary.txt');
TrainingSetNum = length(TrainingBinarySetInfo);
% trainSet = importdata('Training_Set.txt');
% label = trainSet.data;

templateBinarySetInfo = importdata('./zooscan/Template.txt');
templateNum = length(templateBinarySetInfo);

match_cost = [];

for i = 1:TrainingSetNum
    imageNameNum = strfind(TrainingBinarySetInfo{i, 1},'/');
    if ~isempty(imageNameNum)
        imageName=TrainingBinarySetInfo{i, 1}((imageNameNum(1,4)+1):end);
    end
    imgBinary = imread(TrainingBinarySetInfo{i, 1});
    imgBinary = bwmorph(imgBinary,'majority');
    for j = 1:templateNum
        imgTemplate = imread(templateBinarySetInfo{j, 1});
        match_cost(i,j)=comIDSC(imgBinary,imgTemplate);
    end
end
lowvec=min(match_cost);  
upvec=max(match_cost);
trainFeature = scaling( match_cost,lowvec,upvec);

save ./zooscan/zooscan-Train-Features-IDSC.mat trainFeature
