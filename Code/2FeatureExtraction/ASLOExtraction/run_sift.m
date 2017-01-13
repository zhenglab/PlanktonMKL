clear
clc

addpath(genpath('featuresFunction/'));

DatasetName='trainingASLO';
TrainingSetInfo = importdata('./ASLO/trainingASLO.txt');
TrainingSetNum = length(TrainingSetInfo.data);
TestingSetInfo = importdata('./ASLO/testingASLO.txt');
TestingSetNum = length(TestingSetInfo.data);
numWords = 100;

descrs = {} ;
for i = 1:TrainingSetNum
    img = im2single(imread(TrainingSetInfo.textdata{i, 1}));
    [~,b{i}] = vl_sift(img);
end
for i = 1:TestingSetNum
    img = im2single(imread(TestingSetInfo.textdata{i, 1}));
    [~,b{TrainingSetNum+i}] = vl_sift(img);
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

save ./ASLO/ASLO-Train-Features-SIFT-100.mat histsTrain;

histsTest = [];
for i = 1:TestingSetNum
    img = im2single(imread(TestingSetInfo.textdata{i, 1}));
    [~,D] = vl_sift(img);
    H = zeros(1,numWords);
    for j=1:size(D,2)
      [~, k] = min(vl_alldist(single(D(:,j)), single(vocab))) ;
      H(k) = H(k) + 1;
    end
    histsTest(i,:) = H;
end
 
save ./ASLO/ASLO-Test-Features-SIFT-100.mat histsTest;