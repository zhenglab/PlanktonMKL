clear
clc

TrainSetInfo = importdata('./ZooScan/ZooScan.txt');
TrainSetNum = length(TrainSetInfo.data);

for i = 1:TrainSetNum
    img = imread(TrainSetInfo.textdata{i, 1});
    
    featureVector = ILBP81ri(img);
    featuresMatrixTrain(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./ZooScan/ZooScan-Train-Features-ILBP81.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
