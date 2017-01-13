clear
clc

addpath(genpath('function/'));

datasetName = 'ASLO';
datasetInfo = importdata('../2FeatureExtraction/ASLOExtraction/ASLO/trainingASLO.txt');
trainLabel = datasetInfo.data;

featuresTrain = load(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features.txt']);
featuresHOGTrain = load(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-HOG.txt']);
featuresGaborTrain = load(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Gabor-Square.txt']);
featuresILBP81Train = load(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-ILBP81.txt']);
featuresIDSCTrain = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-IDSC.mat']);
featuresSIFTTrain100 = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-SIFT-100.mat']);
featuresGranulometryTrain = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Granulometry.txt']);
featuresGranulometryNewTrain = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Granulometry-New.txt']);
featuresVariogramTrain = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Variogram.txt']);
featuresGLCMTrain = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-GLCM.txt']);
featuresBGC81Train = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-BGC81.txt']);

featureSelectionNoPCAResultPath = ['../3featureSelection/result/' datasetName '/'];
featureSelectionNoPCAPathInfo = dir(featureSelectionNoPCAResultPath);
for i = 1:length(featureSelectionNoPCAPathInfo)
    if featureSelectionNoPCAPathInfo(i).name(1) == '.' || featureSelectionNoPCAPathInfo(i).name(end) ~= 't'
        continue
    end
     load([featureSelectionNoPCAResultPath featureSelectionNoPCAPathInfo(i).name])
end

trainingFeatures = {featuresTrain(:,fsfs),featuresHOGTrain(:,fsHOG),featuresGaborTrain(:,fsGabor),featuresILBP81Train(:,fsfsILBP81),featuresIDSCTrain(:,fsIDSC),featuresSIFTTrain100(:,fsSIFT100),featuresGranulometryTrain(:,fsfsGranulometry),featuresGranulometryNewTrain(:,fsfsGranulometryNew),featuresVariogramTrain(:,fsfsVariogram),featuresGLCMTrain(:,fsfsGLCM),featuresBGC81Train(:,fsfsBGC81)};% 训练集特征
featureClass = {'fsfs';'fsHOG';'fsGabor';'fsfsILBP81';'fsIDSC';'fsSIFT100';'fsfsGranulometry';'fsfsGranulometryNew';'fsfsVariogram';'fsfsGLCM';'fsfsBGC81'};

if ~isdir(['./result/' datasetName '/']);
    mkdir(['./result/' datasetName '/']);
end

for i=1:length(trainingFeatures)
    SeleParamResultName = ['./result/' datasetName '/' featureClass{i} '-Features-Param.txt']; 
    [bestcSele, bestgSele] = crossValidation2(trainingFeatures{i},trainLabel,SeleParamResultName);
end
