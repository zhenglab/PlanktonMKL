clear all
close all
clc

addpath(genpath('./function/'));

datasetName = 'ZooScan';
trainSet = importdata('../../2FeatureExtraction/ZooScanExtraction/ZooScan/ZooScan.txt');
label = trainSet.data;
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

featureSelectionNoPCAResultPath = ['../../3FeatureSelection/result/' datasetName '/'];
featureSelectionNoPCAPathInfo = dir(featureSelectionNoPCAResultPath);
for i = 1:length(featureSelectionNoPCAPathInfo)
    if featureSelectionNoPCAPathInfo(i).name(1) == '.' || featureSelectionNoPCAPathInfo(i).name(end) ~= 't'
        continue
    end
     load([featureSelectionNoPCAResultPath featureSelectionNoPCAPathInfo(i).name])
end
features = {featuresTrain(:,fsfs);featuresHOGTrain(:,fsHOG);featuresGaborTrain(:,fsGabor);featuresILBP81Train(:,fsILBP81);featuresIDSCTrain(:,fsIDSC);featuresSIFTTrain100(:,fsSIFT100);featuresGranulometryTrain(:,fsGranulometry);featuresGranulometryNewTrain(:,fsGranulometryNew);featuresVariogramTrain(:,fsVariogram);featuresGLCMTrain(:,fsGLCM);featuresBGC81Train(:,fsBGC81)};% 训练集特征
featureClass = {'fsfs';'fsHOG';'fsGabor';'fsfsILBP81';'fsIDSC';'fsSIFT100';'fsfsGranulometry';'fsfsGranulometryNew';'fsfsVariogram';'fsfsGLCM';'fsfsBGC81'};

repetitions = 1;
folds = 2;

indices = crossvalind('Kfold', trainSetNum, folds);
    
training_data = cell(1, 1);            grid_data = cell(1, 1);

% ker = {'l' 'p2' 'g2'};
%     for i =1:length(features)
%             training.X = features{i};% 训练集数据
%             grid.X = featuresTestAll{i};  

% ker = {{'g31.62' 'g3.16' 'g0.12' 'g0.22' 'g3.16' 'g3.16' 'g0.38' 'g0.22' 'g0.9' 'g0.22' 'g0.22'} {'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l'} {'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2'}};
ker = {{'g4' 'g4' 'g2' 'g2' 'g2' 'g8' 'g0.5' 'g0.5' 'g0.5' 'g0.5' 'g2'} {'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l'} {'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2'}};
cMatrix = [0.1,1,10,100];
kerName = {'gaussian' 'linear' 'poly'};

for numC =1:length(cMatrix)
    for numKer = 1:1%length(kerName)
        num=1;
        for k = 1:folds
            test = (indices == k); 
            train = ~test;
            training.y = label(train);
            labelTest = label(test);

            training.ind = (1:length(training.y))';
            result=[];
            for numClass=1:max(label)
                training.y = ones(length(label(train)),1);
                testLabel = ones(length(label(test)),1);
                training.y(label(train)~=numClass)=-1;
                testLabel(label(test)~=numClass)=-1;
                for i =1:length(features)
                    training.X = features{i}(train,:);% 训练集数据
                    grid.X = features{i}(test,:);  

                    training_data{i} = training; grid_data{i} = grid;
                end
                %% 基本分类器的参数
                parameters = nlmksvm_parameter();
                parameters.C = cMatrix(numC);
        %         parameters.ker = {'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l' 'l'};%核函数
        %         parameters.ker = {'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2' 'p2'};%核函数
        %         parameters.ker = {'g2' 'g2' 'g2' 'g2' 'g2' 'g2' 'g2' 'g2' 'g2' 'g2' 'g2'};%核函数
                parameters.ker = ker{numKer};
                parameters.nor.dat = {'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true'};%, 'true'};
                parameters.nor.ker = {'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true' 'true'};% 'true' 'true'};%, 'true'};
                %% SMKL
                model = nlmksvm_train(training_data, parameters);
                output = nlmksvm_test(grid_data, model);
                result(:,numClass) = output.dis;
            end
            for j = 1:length(result)
                [~,predictClass(num,1)] = max(result(j,:));
                actualClass(num,1) = labelTest(j,1);
                num = num+1;
            end
        end
        [cm,order] = confusionmat(actualClass, predictClass);
        resultName = ['./result/' kerName{numKer} '-C-' num2str(cMatrix(numC)) '-smo.txt'];
        writeData(cm, strcat(resultName));
    end
end
