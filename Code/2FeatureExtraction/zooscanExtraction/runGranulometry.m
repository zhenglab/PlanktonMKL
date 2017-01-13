clear
clc
% old参数：5，64，5


TrainSetInfo = importdata('./zooscan/zooscan.txt');
TrainSetNum = length(TrainSetInfo.data);

for i = 1:TrainSetNum
    img = imread(TrainSetInfo.textdata{i, 1});
    
    featureVector = Granulometry(img, 2, 50, 4);
    featuresMatrixNew(i,:) = featureVector;
end

[m n] = size(featuresMatrixNew);
fid = fopen('./zooscan/zooscan-Train-Features-Granulometry-New.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixNew(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

for i = 1:TrainSetNum
    img = imread(TrainSetInfo.textdata{i, 1});
    
    featureVector = Granulometry(img, 5, 64, 5);
    featuresMatrixOld(i,:) = featureVector;
end

[m n] = size(featuresMatrixOld);
fid = fopen('./zooscan/zooscan-Train-Features-Granulometry.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixOld(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);

