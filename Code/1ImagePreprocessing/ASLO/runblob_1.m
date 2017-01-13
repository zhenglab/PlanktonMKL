function runblob_1()
addpath(genpath('function/'));
%% Settings
InputTrain = '../../../Dataset/ASLO/training/';
OutputTrain = './result/ASLOSquareTraining/';
InputTest = '../../../Dataset/ASLO/testing/';
OutputTest = './result/ASLOSquareTesting/';
%% END Settings
traverse(InputTrain, OutputTrain);
traverse(InputTest, OutputTest);
end

function traverse(Input, Output)
idsInput = dir(Input);
    for i = 1:length(idsInput)
        if idsInput(i, 1).name(1)=='.'
            continue;
        end
        if idsInput(i, 1).isdir==1
            if ~isdir(strcat(Output, idsInput(i, 1).name, '/'));
                mkdir(strcat(Output,idsInput(i, 1). name, '/'));
            end
            traverse(strcat(Input, idsInput(i, 1).name, '/'), strcat(Output, idsInput(i, 1).name, '/'));
        else
            if strcmp(idsInput(i, 1).name((end-2):end), 'tif' ) 
                imgfile = fullfile(Input, idsInput(i, 1).name);
                img = imread(imgfile);
                target.config = configure();
                target.image = img;
                target = blob(target);
                imwrite(target.blob_image, strcat(Output, idsInput(i, 1).name(1: (end-4)), '.tif'));
            end
        end
    end
end