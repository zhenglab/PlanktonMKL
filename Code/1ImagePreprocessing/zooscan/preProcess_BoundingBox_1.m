function preProcess_BoundingBox()
addpath('function/');
%% Settings
Input = '../../../Dataset/zooscan/training/';
Output = './result/zooscanBoundingBox/';
%% END Settings
traverse(Input, Output);
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
        if strcmp(idsInput(i, 1).name((end-2):end), 'jpg' ) 
            imgfile = fullfile(Input, idsInput(i, 1).name);
            result = eval(strcat('BoundingBox', '(', 'imgfile', ')'));
            imwrite(result, strcat(Output, idsInput(i, 1).name(1: (end-4)), '.png'));
        end
    end
end
end