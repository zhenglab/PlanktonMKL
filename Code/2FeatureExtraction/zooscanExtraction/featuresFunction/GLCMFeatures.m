function featureVector = GLCMFeatures(imgFile, d, nt, avg, fn)

%Extracts features from co-occurrence matrices
%
%INPUT:
%imgFile        : pointer to a grey-scale image
%d              : distance   
%nt             : neighbourhood type - See COOCMatrices()
%avg            : average matrices - See COOCMatrices()
%fn             : feature normalization for rotation invariance; can be
%                   'NONE'          -> no normalization 
%                   'AVG'           -> average
%                   'AVG+RANGE'     -> average + range
%                   'AVG+RANGE+MAD' -> average + range + mean absolute deviation
%                   'DFT'           -> discrete Fourier transform
%
%OUTPUT:
%featureVector  : the rotation invariant feature vector
%

    
    %Compute co-occurrence matrices
    CM = COOCMatrices(imgFile, d, nt, avg);
    nDisp = size(CM,3);
    
    %Extract features
    featureVector = [];
    featureMatrix = [];
    for d = 1:nDisp
        featureVector_ = [Contrast(CM(:,:,d)),... 
                          Correlation(CM(:,:,d)),... 
                          Energy(CM(:,:,d)),...
                          Entropy(CM(:,:,d)),...
                          Homogeneity(CM(:,:,d))];
        featureMatrix = [featureMatrix; featureVector_];
    end
    
    switch fn
        case 'NONE'
            %Do nothing
            featureVector = reshape(featureMatrix, 1, numel(featureMatrix));
        case 'AVG'
            featureVector = mean(featureMatrix);
        case 'AVG+RANGE'
            featureVector = [mean(featureMatrix), max(featureMatrix) - min(featureMatrix)];
        case 'AVG+MAD'
            featureVector = [mean(featureMatrix), mad(featureMatrix)];
        case 'AVG+RANGE+MAD'
            featureVector = [mean(featureMatrix),...
                             max(featureMatrix) - min(featureMatrix),...
                             mad(featureMatrix)];
        case 'DFT'
            nDisp_redu = floor(nDisp/2) + 1;
            featureMatrix = featureMatrix/nDisp;
            featureMatrix = abs(fft(featureMatrix));
            featureVector = reshape(featureMatrix, 1, numel(featureMatrix));
        case 'DFT+RANGE'
            nDisp_redu = floor(nDisp/2) + 1; 
            featureMatrix = featureMatrix/nDisp;
            featureMatrix = abs(fft(featureMatrix));
            featureMatrix = featureMatrix(1:nDisp_redu,:);
            featureVector = reshape(featureMatrix, 1, numel(featureMatrix));
            featureVector = [featureVector, max(featureMatrix) - min(featureMatrix)];            
        otherwise error('Unsupported method for feature normalization');
    end
end

function [CN] = Contrast(CM)

    %Computes contrast of a co-occurrence matrix
    %
    %INPUT:
    %CM: the co-occurrence matrix
    %
    %OUTPUT
    %CN: contrast value (normalized between 0 and 1)
    %
    
    [rows cols] = size(CM);
    if (rows ~= cols)
        error('Co-occurrence matrix should be square');
    end 
    
    stats = GraycoProps(CM, 'Contrast');    
    CN = (1/((rows-1)^2))*(stats.Contrast);

end

function [CR] = Correlation(CM)

    %Computes correlation of a co-occurrence matrix
    %
    %INPUT:
    %CM: the co-occurrence matrix
    %
    %OUTPUT
    %CR: correlation value (normalized between 0 and 1)
    %
    
    [rows cols] = size(CM);
    if (rows ~= cols)
        error('Co-occurrence matrix should be square');
    end 
    
    stats = GraycoProps(CM, 'Correlation');
    CR = stats.Correlation;
    
    %Normalize 
    CR = (1/2)*CR + 1/2;
end

function [EN] = Energy(CM)

    %Computes energy of a co-occurrence matrix
    %
    %INPUT:
    %CM: the co-occurrence matrix
    %
    %OUTPUT
    %EN: energy (normalized between 0 and 1)
    %
    
    [rows cols] = size(CM);
    if (rows ~= cols)
        error('Co-occurrence matrix should be square');
    end 
    
    stats = GraycoProps(CM, 'Energy');    
    EN = stats.Energy;

end

function [ET] = Entropy(CM)

    %Computes entropy of a co-occurrence matrix
    %
    %INPUT:
    %CM: the co-occurrence matrix
    %
    %OUTPUT
    %ET: entropy (normalized between 0 and 1)
    %
    
    [rows cols] = size(CM);
    if (rows ~= cols)
        error('Co-occurrence matrix should be square');
    end 
    
    ET = 0;
    
    %Compute ENTROPY
    for r = 1:rows
        for c = 1:cols
            if CM(r,c) ~= 0
                ET = ET + CM(r,c)*log2((CM(r,c)));
            end
        end
    end

    %Normalize entropy (entropy is max when all the entries of the matrix are equally probable)
    ET = (-1/(2*log2(rows)))*ET;

end

function [H] = Homogeneity(CM)

    %Computes homogeneity of a co-occurrence matrix
    %
    %INPUT:
    %CM: the co-occurrence matrix
    %
    %OUTPUT
    %H: homogeneity value (normalized between 0 and 1)
    %
    
    [rows cols] = size(CM);
    if (rows ~= cols)
        error('Co-occurrence matrix should be square');
    end 
    
    stats = GraycoProps(CM, 'Homogeneity');    
    H = stats.Homogeneity;
    
end