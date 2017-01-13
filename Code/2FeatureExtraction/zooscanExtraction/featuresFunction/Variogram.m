function [featureVector] = Variogram(I, G, sampleLength)

%Variogram of a grey-scale image
%
%INPUT:
%I:                 grey-scale image
%G:                 number of grey levels
%sampleLength:      length of the variogram
%
%OUTPUT:
%featureVector:     variogram of I
%

    featureVector = [];
    
    I = double(I)/(G - 1);
    
    %Define displacements
    D = [0 1; -1 1; -1 0; -1 -1];
    nDisp = size(D,1);
    
    for d = 1:nDisp
        featureVector = [featureVector; ComputeAverageColourDifferences(I, D(d,:), sampleLength)];
    end
    
    %Average vectors for rotation invariance
    featureVector = mean(featureVector);

end

function [variogram] = ComputeAverageColourDifferences(I, displacements, sampleLength)

    variogram = zeros(1, sampleLength);

    [rows cols channels] = size(I);

    for r = 1:rows
        for c = 1:cols
            
            r_start = r;
            c_start = c;
            
            for d = 1:sampleLength
			
                r_end = r_start + d*displacements(1);
                c_end = c_start + d*displacements(2);
			
                r_end = ConvertToToroidalCoordinate(r_end, rows);
                c_end = ConvertToToroidalCoordinate(c_end, cols);
                
                startValue = I(r_start,c_start);
                endValue = I(r_end,c_end);
            
                colourDiff = (abs(endValue - startValue))^2;
                                           
                variogram(d) = variogram(d) + colourDiff;
                
            end

        end
    end
    
    variogram = variogram/(rows*cols);

end