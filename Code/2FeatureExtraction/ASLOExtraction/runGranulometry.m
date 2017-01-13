clear
clc

addpath(genpath('featuresFunction/'));

TrainSetInfo = importdata('./ASLO/trainingASLO.txt');
TrainSetNum = length(TrainSetInfo.data);
TestSetInfo = importdata('./ASLO/testingASLO.txt');
TestSetNum = length(TestSetInfo.data);
minLength = 2;
maxLength = 50;
step = 4;

for i = 1:TrainSetNum
    img = imread(TrainSetInfo.textdata{i, 1});
    
    featureVector = Granulometry(img, 2, 50, 4);
    featuresMatrixTrainNew(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrainNew);
fid = fopen('./ASLO/ASLO-Train-Features-Granulometry-New.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrainNew(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TestSetNum
    img = imread(TestSetInfo.textdata{i, 1});
    
    featureVector = Granulometry(img, 2, 50, 4);
    featuresMatrixTestNew(i,:) = featureVector;
end

[m n] = size(featuresMatrixTestNew);
fid = fopen('./ASLO/ASLO-Test-Features-Granulometry-New.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTestNew(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TrainSetNum
    img = imread(TrainSetInfo.textdata{i, 1});
    
    featureVector = Granulometry(img, 5, 64, 5);
    featuresMatrixTrainOld(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrainOld);
fid = fopen('./ASLO/ASLO-Train-Features-Granulometry.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrainOld(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TestSetNum
    img = imread(TestSetInfo.textdata{i, 1});
    
    featureVector = Granulometry(img, 5, 64, 5);
    featuresMatrixTestOld(i,:) = featureVector;
end

[m n] = size(featuresMatrixTestOld);
fid = fopen('./ASLO/ASLO-Test-Features-Granulometry.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTestOld(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
