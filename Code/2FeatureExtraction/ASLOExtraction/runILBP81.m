clear
clc

addpath(genpath('featuresFunction/'));

TrainSetInfo = importdata('./ASLO/trainingASLO.txt');
TrainSetNum = length(TrainSetInfo.data);
TestSetInfo = importdata('./ASLO/testingASLO.txt');
TestSetNum = length(TestSetInfo.data);

for i = 1:TrainSetNum
    img = imread(TrainSetInfo.textdata{i, 1});
    
    featureVector = ILBP81ri(img);
    featuresMatrixTrain(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./ASLO/ASLO-Train-Features-ILBP81.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TestSetNum
    img = imread(TestSetInfo.textdata{i, 1});
    
    featureVector = ILBP81ri(img);
    featuresMatrixTest(i,:) = featureVector;
end

[m n] = size(featuresMatrixTest);
fid = fopen('./ASLO/ASLO-Test-Features-ILBP81.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTest(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

