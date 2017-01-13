clear all
close all
clc

addpath(genpath('./function/'));

if ~isdir('./result/');
    mkdir('./result/');
end

datasetName = 'ASLO';
trainSet = importdata('../../2FeatureExtraction/ASLOExtraction/ASLO/trainingASLO.txt');
testSet = importdata('../../2FeatureExtraction/ASLOExtraction/ASLO/testingASLO.txt');
label = trainSet.data;
labelTest = testSet.data;
trainSetNum = length(trainSet.data);

featuresTrain = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features.txt']);
featuresHOGTrain = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-HOG.txt']);
featuresGaborTrain = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Gabor-Square.txt']);
featuresILBP81Train = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-ILBP81.txt']);
featuresIDSCTrain = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-IDSC.mat']);
featuresSIFTTrain100 = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-SIFT-100.mat']);
featuresGranulometryTrain = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Granulometry.txt']);
featuresGranulometryNewTrain = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Granulometry-New.txt']);
featuresVariogramTrain = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Variogram.txt']);
featuresGLCMTrain = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-GLCM.txt']);
featuresBGC81Train = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-BGC81.txt']);

featuresTest = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features.txt']);
featuresHOGTest = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-HOG.txt']);
featuresGaborTest = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-Gabor-Square.txt']);
featuresILBP81Test = load(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-ILBP81.txt']);
featuresIDSCTest = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-IDSC.mat']);
featuresSIFTTest100 = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-SIFT-100.mat']);
featuresGranulometryTest = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-Granulometry.txt']);
featuresGranulometryNewTest = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-Granulometry-New.txt']);
featuresVariogramTest = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-Variogram.txt']);
featuresGLCMTest = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-GLCM.txt']);
featuresBGC81Test = importdata(['../../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Test-Features-BGC81.txt']);

featureSelectionNoPCAResultPath = ['../../3FeatureSelection/result/' datasetName '/'];
featureSelectionNoPCAPathInfo = dir(featureSelectionNoPCAResultPath);
for i = 1:length(featureSelectionNoPCAPathInfo)
    if featureSelectionNoPCAPathInfo(i).name(1) == '.' || featureSelectionNoPCAPathInfo(i).name(end) ~= 't'
        continue
    end
     load([featureSelectionNoPCAResultPath featureSelectionNoPCAPathInfo(i).name])
end
features = {featuresTrain(:,fsfs);featuresHOGTrain(:,fsHOG);featuresGaborTrain(:,fsGabor);featuresILBP81Train(:,fsfsILBP81);featuresIDSCTrain(:,fsIDSC);featuresSIFTTrain100(:,fsSIFT100);featuresGranulometryTrain(:,fsfsGranulometry);featuresGranulometryNewTrain(:,fsfsGranulometryNew);featuresVariogramTrain(:,fsfsVariogram);featuresGLCMTrain(:,fsfsGLCM);featuresBGC81Train(:,fsfsBGC81);...
    featuresTrain(:,fsfs);featuresHOGTrain(:,fsHOG);featuresGaborTrain(:,fsGabor);featuresILBP81Train(:,fsfsILBP81);featuresIDSCTrain(:,fsIDSC);featuresSIFTTrain100(:,fsSIFT100);featuresGranulometryTrain(:,fsfsGranulometry);featuresGranulometryNewTrain(:,fsfsGranulometryNew);featuresVariogramTrain(:,fsfsVariogram);featuresGLCMTrain(:,fsfsGLCM);featuresBGC81Train(:,fsfsBGC81);...
    featuresTrain(:,fsfs);featuresHOGTrain(:,fsHOG);featuresGaborTrain(:,fsGabor);featuresILBP81Train(:,fsfsILBP81);featuresIDSCTrain(:,fsIDSC);featuresSIFTTrain100(:,fsSIFT100);featuresGranulometryTrain(:,fsfsGranulometry);featuresGranulometryNewTrain(:,fsfsGranulometryNew);featuresVariogramTrain(:,fsfsVariogram);featuresGLCMTrain(:,fsfsGLCM);featuresBGC81Train(:,fsfsBGC81)};% 训练集特征
featuresTestAll = {featuresTest(:,fsfs);featuresHOGTest(:,fsHOG);featuresGaborTest(:,fsGabor);featuresILBP81Test(:,fsfsILBP81);featuresIDSCTest(:,fsIDSC);featuresSIFTTest100(:,fsSIFT100);featuresGranulometryTest(:,fsfsGranulometry);featuresGranulometryNewTest(:,fsfsGranulometryNew);featuresVariogramTest(:,fsfsVariogram);featuresGLCMTest(:,fsfsGLCM);featuresBGC81Test(:,fsfsBGC81);...
    featuresTest(:,fsfs);featuresHOGTest(:,fsHOG);featuresGaborTest(:,fsGabor);featuresILBP81Test(:,fsfsILBP81);featuresIDSCTest(:,fsIDSC);featuresSIFTTest100(:,fsSIFT100);featuresGranulometryTest(:,fsfsGranulometry);featuresGranulometryNewTest(:,fsfsGranulometryNew);featuresVariogramTest(:,fsfsVariogram);featuresGLCMTest(:,fsfsGLCM);featuresBGC81Test(:,fsfsBGC81);...
    featuresTest(:,fsfs);featuresHOGTest(:,fsHOG);featuresGaborTest(:,fsGabor);featuresILBP81Test(:,fsfsILBP81);featuresIDSCTest(:,fsIDSC);featuresSIFTTest100(:,fsSIFT100);featuresGranulometryTest(:,fsfsGranulometry);featuresGranulometryNewTest(:,fsfsGranulometryNew);featuresVariogramTest(:,fsfsVariogram);featuresGLCMTest(:,fsfsGLCM);featuresBGC81Test(:,fsfsBGC81)};% 测试集特征
featureClass = {'fsfs';'fsHOG';'fsGabor';'fsfsILBP81';'fsIDSC';'fsSIFT100';'fsfsGranulometry';'fsfsGranulometryNew';'fsfsVariogram';'fsfsGLCM';'fsfsBGC81'};

training.ind = (1:length(label))';
training.y = label;
training_data = cell(1, 1);            grid_data = cell(1, 1);

ker = {{'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'g8' 'g16' 'g16' 'g4' 'g32' 'g16' 'g4' 'g4' 'g2' 'g2' 'g4'}};
cMatrix = [100,10,1,0.1];
kerName = {'linear+poly+gaussian'};

for numC =1:length(cMatrix)
    for numKer = 1:length(kerName)
        for numClass=1:max(label)
            training.y = ones(length(trainSet.data),1);
            testLabel = ones(length(testSet.data),1);
            training.y(label~=numClass)=-1;
            testLabel(labelTest~=numClass)=-1;
            for i =1:length(features)
                training.X = features{i};% 训练集数据
                grid.X = featuresTestAll{i};  

                training_data{i} = training; grid_data{i} = grid;
            end
            %% 基本分类器的参数
            parameters = nlmksvm_parameter();
            parameters.C = cMatrix(numC);
            parameters.ker = ker{numKer};
            parameters.nor.dat = {'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true'};%, 'true'};
            parameters.nor.ker = {'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true'};%, 'true'};
            %% SMKL
            model = nlmksvm_train(training_data, parameters);
            output = nlmksvm_test(grid_data, model);
            result(:,numClass) = output.dis;
        end
        for j = 1:length(label)
            [~,predictClass(j,1)] = max(result(j,:));
        end
        [cm,order] = confusionmat(labelTest, predictClass);
        resultName = ['./result/' kerName{numKer} '-C-' num2str(cMatrix(numC)) '-smo.txt'];
        writeData(cm, strcat(resultName));
    end
end
