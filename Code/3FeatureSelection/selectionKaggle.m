clear
clc

datasetName = 'Kaggle';

if ~isdir('./result/Kaggle/');
    mkdir('./result/Kaggle/');
end

featuresGabor = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Gabor-Square.txt']);
featuresSIFT100 = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-SIFT-100.mat']);
featuresHOG = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-HOG.txt']);
features = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features.txt']);
featuresIDSC = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-IDSC.mat']);
featuresGranulometry = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Granulometry.txt']);
featuresGranulometryNew = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Granulometry-New.txt']);
featuresGLCM = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-GLCM.txt']);
featuresILBP81 = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-ILBP81.txt']);
featuresVariogram = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Variogram.txt']);
featuresBGC81 = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-BGC81.txt']);

y = importdata(['./' datasetName '/trainOriginal.txt']);


[fsGabor history1] = sequentialfs(@classf,featuresGabor,y);
save ./result/Kaggle/featureSelection-training-Gabor.mat fsGabor;
[fsSIFT100 history2] = sequentialfs(@classf,featuresSIFT100,y);
save ./result/Kaggle/featureSelection-training-SIFT-100.mat fsSIFT100;
[fsHOG history3] = sequentialfs(@classf,featuresHOG,y);
save ./result/Kaggle/featureSelection-training-HOG.mat fsHOG;
[fsfs history4] = sequentialfs(@classf,features,y);
save ./result/Kaggle/featureSelection-training-features.mat fsfs;
[fsIDSC history5] = sequentialfs(@classf,featuresIDSC,y);
save ./result/Kaggle/featureSelection-training-IDSC.mat fsIDSC;
[fsGranulometry history6] = sequentialfs(@classf,featuresGranulometry,y);
save ./result/Kaggle/featureSelection-training-features-Granulometry.mat fsGranulometry;
[fsGranulometryNew history7] = sequentialfs(@classf,featuresGranulometryNew,y);
save ./result/Kaggle/featureSelection-training-features-Granulometry-New.mat fsGranulometryNew;
[fsGLCM history8] = sequentialfs(@classf,featuresGLCM,y);
save ./result/Kaggle/featureSelection-training-features-GLCM.mat fsGLCM;
[fsILBP81 history9] = sequentialfs(@classf,featuresILBP81,y);
save ./result/Kaggle/featureSelection-training-features-ILBP81.mat fsILBP81;
[fsVariogram history10] = sequentialfs(@classf,featuresVariogram,y);
save ./result/Kaggle/featureSelection-training-features-Variogram.mat fsVariogram;
[fsBGC81 history11] = sequentialfs(@classf,featuresBGC81,y);
save ./result/Kaggle/featureSelection-training-features-BGC81.mat fsBGC81;

