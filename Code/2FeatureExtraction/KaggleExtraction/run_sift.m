clear
clc

addpath(genpath('featuresFunction/'));

TrainingSetInfo = importdata('./Kaggle/Kaggle.txt');
TrainingSetNum = length(TrainingSetInfo.data);
numWords = 100;

descrs = {} ;
for i = 1:TrainingSetNum
    img = im2single(imread(TrainingSetInfo.textdata{i, 1}));
    [~,b{i}] = vl_sift(img);
end
descrs = cat(2, b{:});
descrs = single(descrs) ;
% Quantize the descriptors to get the visual words
vocab = vl_kmeans(descrs, numWords) ;

histsTrain = [];
for i = 1:TrainingSetNum
    img = im2single(imread(TrainingSetInfo.textdata{i, 1}));
    [~,D] = vl_sift(img);
    H = zeros(1,numWords);
    for j=1:size(D,2)
      [~, k] = min(vl_alldist(single(D(:,j)), single(vocab))) ;
      H(k) = H(k) + 1;
    end
    histsTrain(i,:) = H;
end

save ./Kaggle/Kaggle-Train-Features-SIFT-100.mat histsTrain;
