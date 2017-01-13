function [featureVector] = Granulometry(I, minLength, maxLength, step)

%Granulometry of a grey-scale image. Structuring element =
%line.
%
%INPUT:
%I:                 grey-scale image
%minLength:         mininum length of the structuring element
%maxLength:         maximum length of the structuring element
%step:              increment
%
%OUTPUT:
%featureVector:     granulometry of I
%
    
    [rows cols channels] = size(I);
    
    granulometricCurves = [];
    featureVector = [];
    
    %Rotation angles
    rot = [0, 45, 90, 135];
    nAngles = length(rot);
    
    for i = 1:nAngles
        granulometricCurves = [granulometricCurves; ComputeGranulometricCurve(I, rot(i), minLength, maxLength, step)];
    end
        
    %Average features for rotation-invariance
    featureVector = [featureVector, mean(granulometricCurves)];

end

function [granulometricCurve] = ComputeGranulometricCurve(I, angle, minLength, maxLength, step);

    %Image volume
    imgVol = sum(sum(I));
    
    %Volumes of openings and closings
    openingVolumes = [];
    closingVolumes = [];
    
    %Compute openings and closings
    for l = minLength:step:maxLength
        
        %Define a linear structuring element
        se = strel('line', l, angle);
        
        openedImage = imopen(I, se); 
        closedImage = imclose(I, se);
        
        %Append volumes
        openingVolumes = [openingVolumes, sum(sum(openedImage))/imgVol];
        closingVolumes = [closingVolumes, sum(sum(closedImage))/imgVol];
    end

    granulometricCurve = [fliplr(closingVolumes), openingVolumes];
    
end