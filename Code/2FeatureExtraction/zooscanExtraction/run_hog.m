clear
clc
TrainingSetInfo = importdata('./zooscan/zooscan.txt');
TrainingSetNum = length(TrainingSetInfo.data);

cellSize = 32;
imgSize = 256;
%% For random dividing - cross validation
for i = 1:TrainingSetNum
    img = single(imread(TrainingSetInfo.textdata{i, 1}));
    
    img = imresize(img, [imgSize imgSize]);
    hogmatrix = vl_hog(img, cellSize);
    hogvector = hogmatrix(:)';
    
    featuresMatrixTrain(i,:) = hogvector;
end

[m n] = size(featuresMatrixTrain);
fid = fopen('./zooscan/zooscan-Train-Features-HOG.txt','w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrixTrain(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);