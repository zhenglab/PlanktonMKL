clear
clc

datasetName = 'ASLO';

if ~isdir('./result/ASLO/');
    mkdir('./result/ASLO/');
end

featuresGaborNew = importdata(['../2FeatureExtraction/' datasetName 'Extraction/' datasetName '/' datasetName '-Train-Features-Gabor-Square-New.txt']);
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

y = importdata(['./' datasetName '/trainingOriginal.txt']);

[fsGaborNew history1] = sequentialfs(@classf,featuresGaborNew,y);
save ./result/ASLO/featureSelection-training-Gabor-New.mat fsGaborNew;
[fsSIFT100 history2] = sequentialfs(@classf,featuresSIFT100,y);
save ./result/ASLO/featureSelection-training-SIFT-100.mat fsSIFT100;
[fsHOG history4] = sequentialfs(@classf,featuresHOG,y);
save ./result/ASLO/featureSelection-training-HOG.mat fsHOG;
[fsfs history5] = sequentialfs(@classf,features,y);
save ./result/ASLO/featureSelection-training-features.mat fsfs;
[fsIDSC history6] = sequentialfs(@classf,featuresIDSC,y);
save ./result/ASLO/featureSelection-training-IDSC.mat fsIDSC;
[fsfsGranulometry history5] = sequentialfs(@classf,featuresGranulometry,y);
save ./result/ASLO/featureSelection-training-features-Granulometry.mat fsfsGranulometry;
[fsfsGranulometryNew history5] = sequentialfs(@classf,featuresGranulometryNew,y);
save ./result/ASLO/featureSelection-training-features-Granulometry-New.mat fsfsGranulometryNew;
[fsfsGLCM history5] = sequentialfs(@classf,featuresGLCM,y);
save ./result/ASLO/featureSelection-training-features-GLCM.mat fsfsGLCM;
[fsfsILBP81 history5] = sequentialfs(@classf,featuresILBP81,y);
save ./result/ASLO/featureSelection-training-features-ILBP81.mat fsfsILBP81;
[fsfsVariogram history5] = sequentialfs(@classf,featuresVariogram,y);
save ./result/ASLO/featureSelection-training-features-Variogram.mat fsfsVariogram;
[fsfsBGC81 history5] = sequentialfs(@classf,featuresBGC81,y);
save ./result/ASLO/featureSelection-training-features-BGC81.mat fsfsBGC81;
