clear
clc

addpath(genpath('featuresFunction/'));

TrainSetInfo = importdata('./ASLO/trainingASLO.txt');
TrainSetNum = length(TrainSetInfo.data);
TestSetInfo = importdata('./ASLO/testingASLO.txt');
TestSetNum = length(TestSetInfo.data);

for i = 1:TrainSetNum 
    img = imread(TrainSetInfo.textdata{i, 1});
    imgInfo = imfinfo(TrainSetInfo.textdata{i, 1});
    
    G = 2^imgInfo.BitDepth;
    featureVector = Variogram(img, G, 20);
    featuresMatrixTrain(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./ASLO/ASLO-Train-Features-Variogram.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TestSetNum 
    img = imread(TestSetInfo.textdata{i, 1});
    imgInfo = imfinfo(TestSetInfo.textdata{i, 1});
    
    G = 2^imgInfo.BitDepth;
    featureVector = Variogram(img, G, 20);
    featuresMatrixTest(i,:) = featureVector;
end

[m n] = size(featuresMatrixTest);
fid = fopen('./ASLO/ASLO-Test-Features-Variogram.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTest(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
