function features = grayExtraction(img, imgBinary, features)

[x,y] = size(img);

pos = 1;
grayValue = [];
for i = 1:x
    for j = 1:y
        if imgBinary(i,j)==1
            grayValue(pos) = img(i,j);
            pos = pos+1;
        end
    end
end

glcm = graycomatrix(img);
stats = graycoprops(glcm);

features.sumGray = sum(grayValue);
features.minGray = min(grayValue);
features.maxGray = max(grayValue);
features.meanGray = mean(grayValue);
features.modeGray = mode(grayValue);
features.medianGray = median(grayValue);
features.stdDevGray = std(grayValue);
features.rangeGray = features.maxGray-features.minGray;
features.contrast = stats.Contrast;
features.correlation = stats.Correlation;
features.energy = stats.Energy;
features.homogemeity = stats.Homogeneity;