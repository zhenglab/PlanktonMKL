clear
clc

addpath(genpath('featuresFunction/'));

TrainSetInfo = importdata('./zooscan/zooscan.txt');
TrainSetNum = length(TrainSetInfo.data);

for i = 1:TrainSetNum
    featureVector = GLCMFeatures(TrainSetInfo.textdata{i, 1}, 2, 'PET', 'Y', 'NONE');
    featuresMatrixTrain(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./zooscan/zooscan-Train-Features-GLCM.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
