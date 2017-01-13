function PreprocessSquare()
addpath(genpath('function/'));
%% Settings
% Input = '../../Dataset/Kaggle/train/';
InputTrain = './result/ASLOSeg/training/';
OutputTrain = './result/ASLOSquare/training/';
InputTest = './result/ASLOSeg/testing/';
OutputTest = './result/ASLOSquare/testing/';
BinaryResultTrain = './result/ASLOBinarySquare/training/';
BinaryResultTest = './result/ASLOBinarySquare/testing/';
%% END Settings
traverse(InputTrain, OutputTrain, BinaryResultTrain);
traverse(InputTest, OutputTest, BinaryResultTest);
end

function traverse(Input, Output, BinaryResult)
idsInput = dir(Input);
    for i = 1:length(idsInput)
        if idsInput(i, 1).name(1)=='.'
            continue;
        end
        if idsInput(i, 1).isdir==1
            if ~isdir(strcat(Output, idsInput(i, 1).name, '/'));
                mkdir(strcat(Output,idsInput(i, 1). name, '/'));
            end
            if ~isdir(strcat(BinaryResult, idsInput(i, 1).name, '/'));
                mkdir(strcat(BinaryResult, idsInput(i, 1). name, '/'));
            end
            traverse(strcat(Input, idsInput(i, 1).name, '/'), strcat(Output, idsInput(i, 1).name, '/'), strcat(BinaryResult, idsInput(i, 1).name, '/'));
        else
            if strcmp(idsInput(i, 1).name((end-2):end), 'png' ) 
                imgfile = fullfile(Input, idsInput(i, 1).name);
                result = eval(strcat('square_fill', '(', 'imgfile', ')'));
                result = uint8(255*mat2gray(result));
                imwrite(result, strcat(Output, idsInput(i, 1).name(1: (end-4)), '.png'));
                img = 255-result;
                imgbw = im2bw(img,3/255);
                L = bwareaopen(imgbw, 5);
                imwrite(L, strcat(BinaryResult, idsInput(i, 1).name(1: (end-4)), '.png'));
            end
        end
    end
end