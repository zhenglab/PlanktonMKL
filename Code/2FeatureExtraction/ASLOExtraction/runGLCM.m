clear
clc

addpath(genpath('featuresFunction/'));

TrainSetInfo = importdata('./ASLO/trainingASLO.txt');
TrainSetNum = length(TrainSetInfo.data);
TestSetInfo = importdata('./ASLO/testingASLO.txt');
TestSetNum = length(TestSetInfo.data);

for i = 1:TrainSetNum
    featureVector = GLCMFeatures(TrainSetInfo.textdata{i, 1}, 2, 'PET', 'Y', 'NONE');
    featuresMatrixTrain(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./ASLO/ASLO-Train-Features-GLCM.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TestSetNum
    featureVector = GLCMFeatures(TestSetInfo.textdata{i, 1}, 2, 'PET', 'Y', 'NONE');
    featuresMatrixTest(i,:) = featureVector;
end

[m n] = size(featuresMatrixTest);
fid = fopen('./ASLO/ASLO-Test-Features-GLCM.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTest(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
