clear
clc

TrainSetInfo = importdata('./zooscan/zooscan.txt');
TrainSetNum = length(TrainSetInfo.data);

for i = 1:TrainSetNum 
    img = imread(TrainSetInfo.textdata{i, 1});
    imgInfo = imfinfo(TrainSetInfo.textdata{i, 1});
    
    G = 2^imgInfo.BitDepth;
    featureVector = Variogram(img, G, 20);
    featuresMatrixTrain(i,:) = featureVector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./zooscan/zooscan-Train-Features-Variogram.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
