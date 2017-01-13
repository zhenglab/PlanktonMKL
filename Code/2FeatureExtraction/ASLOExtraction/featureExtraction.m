function featureExtraction()
addpath(genpath('featuresFunction/'));

TrainSetInfo = importdata('./ASLO/trainingASLO.txt');
TrainBinarySetInfo = importdata('./ASLO/trainingASLOBinary.txt');
TestSetInfo = importdata('./ASLO/testingASLO.txt');
TestBinarySetInfo = importdata('./ASLO/testingASLOBinary.txt');
TrainSetNum = length(TrainBinarySetInfo);

extraction(TrainSetInfo, TrainBinarySetInfo, TrainSetNum, 'Train');
extraction(TestSetInfo, TestBinarySetInfo, TrainSetNum, 'Test');
end

function extraction(TrainSetInfo, TrainBinarySetInfo, TrainSetNum, str)
for i = 1:TrainSetNum
    imageNameNum = strfind(TrainBinarySetInfo{i, 1},'/');
    if ~isempty(imageNameNum)
        imageName=TrainBinarySetInfo{i, 1}((imageNameNum(1,7)+1):end);
    end
    imgBinary = imread(TrainBinarySetInfo{i, 1});   
    img = imread(TrainSetInfo.textdata{i, 1});
    [imgRows,imgCols] = size(img);
    
    num = 1;
    imgGray = [];
    for x=1:imgRows
        for y=1:imgCols
            if imgBinary(x,y)==1
                imgGray(num) = img(x,y);
                num = num+1;
            end
        end
    end
    
    regionFeatures = regionprops(imgBinary,{'area','FilledArea','MajorAxisLength','MinorAxisLength','Eccentricity','Orientation',...
        'FilledArea','ConvexArea','EulerNumber','EquivDiameter','Solidity','Extent','Perimeter'});
    
    regionFeaturesAll = regionprops(imgBinary,'all');
    regionFeaturesWH = regionprops(imgBinary,'BoundingBox');
    regionFeaturesConv = regionprops(imgBinary,'ConvexImage');
    regionFeaturesCentroid = regionprops(imgBinary,'Centroid');
    
    [~,ind] = sort([regionFeatures.Area], 2,'descend');
    features = regionFeatures(ind(1));
    
    features = grayExtraction(img, imgBinary, features);
    
    features.IntDen = sum([regionFeatures(:).Area])*features.meanGray;
    features.feret = imMaxFeretDiameter(imgBinary);
    features.circularity = (4*pi*features.Area)/features.Perimeter^2;
    features.elongation = features.MajorAxisLength/features.MinorAxisLength;
    features.convexHull = features.Area/features.ConvexArea;
    features.wh = regionFeaturesWH(ind(1)).BoundingBox(3)/regionFeaturesWH(ind(1)).BoundingBox(4);
    features.perimArea = features.Perimeter/features.Area;
    
    convexPerim = regionprops(regionFeaturesConv(ind(1)).ConvexImage,'Perimeter');
    features.convexPerim = convexPerim.Perimeter;
    
    B = imrotate(imgBinary,pi-features.Orientation,'bicubic','crop');
    BSymmetryY = max((imgCols-round(regionFeaturesCentroid(ind(1)).Centroid(2)))*2,round(regionFeaturesCentroid(ind(1)).Centroid(2))*2);
    BSymmetry = zeros(imgRows,BSymmetryY);
    BSymmetry(:,(BSymmetryY/2-round(regionFeaturesCentroid(ind(1)).Centroid(2))+1):(BSymmetryY/2+imgCols-round(regionFeaturesCentroid(ind(1)).Centroid(2)))) = B;
    BFX = flipud(BSymmetry);
    BFY = fliplr(BSymmetry);
    BorBFX = BSymmetry | BFX;
    BorBFY = BSymmetry | BFY;
    symmetryX = sum(sum(BorBFX))/sum(sum(BSymmetry));
    symmetryY = sum(sum(BorBFY))/sum(sum(BSymmetry));
    
    features.symmetryX = symmetryX;
    features.symmetryY = symmetryY;
    
    features = invmomentsExtraction(img, features);

    grayHist = hist(imgGray,256);
    features.skew = skewness(grayHist);
    features.ESD = 2*(sqrt(features.Area/pi));
    
    featuresCell = struct2cell(features);
    featuresMatrix(i,:) = cell2mat(featuresCell)';
end

[m n] = size(featuresMatrix);
fid = fopen(['./ASLO/ASLO-' str '-Features.txt'],'w');
for i = 1:m
    for j = 1:n
        fprintf(fid, '%g\t', featuresMatrix(i,j)); 
    end
    fprintf(fid, '\n');
end
fclose(fid);
end
