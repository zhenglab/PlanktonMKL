close all;
clear all;
clc;

addpath(genpath('featuresFunction/'));

TrainingBinarySetInfo = importdata('./ASLO/trainingASLOBinary.txt');
TrainingSetNum = length(TrainingBinarySetInfo);
TestingBinarySetInfo = importdata('./ASLO/testingASLOBinary.txt');
TestingSetNum = length(TestingBinarySetInfo);
% trainSet = importdata('Training_Set.txt');
% label = trainSet.data;

templateBinarySetInfo = importdata('./ASLO/Template.txt');
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

save ./ASLO/ASLO-Train-Features-IDSC.mat trainFeature

match_cost = [];

for i = 1:TrainingSetNum
    imageNameNum = strfind(TestingBinarySetInfo{i, 1},'/');
    if ~isempty(imageNameNum)
        imageName=TestingBinarySetInfo{i, 1}((imageNameNum(1,4)+1):end);
    end
    imgBinary = imread(TestingBinarySetInfo{i, 1});
    imgBinary = bwmorph(imgBinary,'majority');
    for j = 1:templateNum
        imgTemplate = imread(templateBinarySetInfo{j, 1});
        match_cost(i,j)=comIDSC(imgBinary,imgTemplate);
    end
end
lowvec=min(match_cost);  
upvec=max(match_cost);
testFeature = scaling( match_cost,lowvec,upvec);

save ./ASLO/ASLO-Test-Features-IDSC.mat testFeature