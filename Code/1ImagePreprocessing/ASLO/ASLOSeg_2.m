function ASLOSeg()
addpath(genpath('function/'));
imgOriginTrain = '../../../Dataset/ASLO/training/';
imgOriginTest = '../../../Dataset/ASLO/testing/';
%% Settings
InputTrain = './result/ASLOSquareTraining/';
OutputTrain = './result/ASLOSeg/training/';
InputTest = './result/ASLOSquareTesting/';
OutputTest = './result/ASLOSeg/testing/';
%% END Settings
traverse(InputTrain, OutputTrain, imgOriginTrain);
traverse(InputTest, OutputTest, imgOriginTest);
end

function traverse(Input, Output, Org)
idsInput = dir(Input);
    for i = 1:length(idsInput)
        if idsInput(i, 1).name(1)=='.'
            continue;
        end
        if idsInput(i, 1).isdir==1
            if ~isdir(strcat(Output, idsInput(i, 1).name, '/'));
                mkdir(strcat(Output,idsInput(i, 1). name, '/'));
            end
            traverse(strcat(Input, idsInput(i, 1).name, '/'), strcat(Output, idsInput(i, 1).name, '/'), strcat(Org, idsInput(i, 1).name, '/'));
        else
            if strcmp(idsInput(i, 1).name((end-2):end), 'tif' ) 
                imgfile = fullfile(Input, idsInput(i, 1).name);
                imgfileOrg = fullfile(Org, idsInput(i, 1).name);
                imgOrigin = imread(imgfileOrg);
                imgBinary = imread(imgfile);

                imgMid = double(255-imgOrigin).*double(imgBinary);
                imgSeg = uint8(255-imgMid);
                imwrite(imgSeg, strcat(Output, idsInput(i, 1).name(1: (end-4)), '.png'));
            end
        end
    end
end
