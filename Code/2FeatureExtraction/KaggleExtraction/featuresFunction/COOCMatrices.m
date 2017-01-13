function [CM] = COOCMatrices(imgFile, d, nt, avg)

%Computes grey-level co-occurrence matrices
%
%INPUT
%imgFile: path to the gray-scale image file
%d      : distance at which the matrices are computed (integer)
%nt     : type of neighbourhood
%                can be:    'HAR'  Haralick's original implementation - four directions
%                                  See R. M. Haralick et al.; "Textural features
%                                  for image classification." IEEE Transactions on Systems, Man, and
%                                  Cybernetics, 3(6):610�621, 1973.
%                           'PET'  Petrou's digital circles
%                                  See M. Petrou and M. Petrou and P. Garc韆 Sevilla; "Image Processing. 
%                                  Dealing with Texture." Wiley Interscience, 2006.
%avg    : average matrices ('Y' = co-occurrence matrices are averaged)
%
%OUTPUT
%CM     :  stack of one (if avg == 'Y') or more co-occurrence matrices
%          (if avg ~= 'Y')
%
%imgWidth:  width of the input image
%imgHeight: height of the input image
    
    %Displacements
    D = [];
    
    switch nt
        case 'HAR'
            D = [0 d; -d d; -d 0; -d -d];
        case 'PET'
            switch d
                case 1
                    D = [-1 1; 0 1; 1 1; 1 0];
                case 2
                    D = [-2 1; -1 2; 0 2; 1 2; 2 1; 2 0];
                case 3
                    D = [-3 1; -2 2; -1 3; 0 3; 1 3; 2 2; 3 1; 3 0];
                case 4
                    D = [-4 1; -4 2; -3 2; -3 3; -2 3; -2 4; -1 4; 0 4; 1 4; 2 4; 2 3; 3 3; 3 2; 4 2; 4 1; 4 0];
                otherwise
                error('Unsupported displacement');
            end
        otherwise
            error('Unsupported neighbourhood');
    end
        
    %Number of displacements
    nDisp = size(D, 1);
    
    %Read image and image's info
    img = imread(imgFile);
    imgInfo = imfinfo(imgFile);
    bitDepth = imgInfo.BitDepth;
    
    %If more than one channel retain the first
    if size(img, 3) > 1
        bitDepth = bitDepth/size(img, 3);
        img = img(:,:,1);
    end

    %Compute matrices
    CM = ComputeCooccurrenceMatrices(img, img, 2^(bitDepth), D, 'Y');
     
    %Average matrices if required
    if avg == 'Y'
        CM = mean(CM, 3);
    end
    
end

function CM = ComputeCooccurrenceMatrices(I1, I2, G, displacements, symmetrize);

%Computes grey-level co-occurrence matrices given a set of displacements.
%Uses toroidal scan.
%
%INPUT
%I1            : grey-scale image
%I2            : grey-scale image      
%I1 and I2 can be the same image
%
%G             : number of grey levels
%
%displacements : displacements at which the co-occurrence matrices are
%computed (matrix of N x 2 integers)
%                   Example: d = [1 1] -> 1 pixel right / 1 pixel up
%                            d = [0 1] -> 0 pixel right / 1 pixel up
%                            d = [-1 0] -> 1 pixel left / 0 pixel up
%
%OUTPUT
%
%CM            :  stack of N co-occurrence matrices (3D matrix - G x G x N)

    [rows cols] = size(I1);

    if [rows cols] ~= size(I2)
        error('The input images should be of same size'); 
    end

    nDisplacements = size(displacements, 1);

    CM = zeros(G, G, nDisplacements);

    for d = 1:nDisplacements
    			
        for r = 1:rows
            for c = 1:cols

                r_I2 = r + displacements(d,2);
                c_I2 = c + displacements(d,1);
                
                %Do toroidal scanning
                r_I2 = ConvertToToroidalCoordinates(r_I2, rows);
                c_I2 = ConvertToToroidalCoordinates(c_I2, cols);
						
                CM(I1(r,c) + 1, I2(r_I2,c_I2) + 1, d) = CM(I1(r,c) + 1, I2(r_I2,c_I2) + 1, d) + 1;
            end
        end
    end

    %Normalize matrices
    for d = 1:nDisplacements
        CM(:,:,d) = CM(:,:,d)/(rows * cols);
    end

    %Symmetrize matrices if required
    if symmetrize == 'Y'
        for n = 1:nDisplacements
            CM(:,:,n) = (CM(:,:,n) + CM(:,:,n)')/2;
        end
    end

end

function [newValue] = ConvertToToroidalCoordinates(value, maxValue)

    if value > maxValue
        newValue = (value - maxValue);
    elseif value < 1
        newValue = (value + maxValue);
    else 
        newValue = value;
    end
			
end