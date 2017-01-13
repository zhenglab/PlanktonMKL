function [textureFeatures, filteredImages] = Gabor(image, maxFreq, numberOfFrequencies, numberOfOrientations, eta, gamma, k)
%
%Compute Gabor features
%
%INPUT:
%image:                 grey-scale image
%maxFreq:               maximum frequency of the filter bank
%numberOfFrequencies:   no. of frequencies of the filter bank
%numberOfOrientations:  no. of orientations of the filter bank
%eta:                   smoothting parameter eta
%gamma:                 smoothing parameter gamma
%k:                     frequency ratio
%
%
%OUTPUT:
%textureFeatures:       feature vector (mean and std of the magnitudes of each transformed image)
%filteredImages:        the transformed images
%

    %number of orientation: number of filters spanning 180�
    %number of frequencies: number of frequencies in the filter bank
    %maxFreq maximum frequence of the filter bank (in cycles/image)
    bank = sg_createfilterbank(size(image), maxFreq, numberOfFrequencies, numberOfOrientations, 'eta', eta, 'gamma', gamma, 'k', k);


    filteredImages_raw = sg_filterwithbank(double(image),bank);

    normalize = 'Y';

    if normalize == 'Y'
        filteredImages = sg_resp2samplematrix(filteredImages_raw,'normalize',1);
    else
        filteredImages = sg_resp2samplematrix(filteredImages_raw,'normalize',0);
    end

    nImages = size(filteredImages);
    nImages = nImages(3);

    index = 1;
    for i = 1:nImages
        textureFeatures(index) = mean2(abs(filteredImages(:,:,i)));
        index = index + 1;
        textureFeatures(index) = std2(abs(filteredImages(:,:,i)));
        index = index + 1;
    end 

end