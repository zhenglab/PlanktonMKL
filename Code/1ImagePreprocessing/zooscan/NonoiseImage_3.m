function NonoiseImage()
addpath('function/');
%% Settings
Input = './result/ZooScanSquare/';
NonoiseResultName = './result/ZooScanNonoise/';
BinaryResultName = './result/ZooScanBinary/';
%% END Settings
traverse(Input, NonoiseResultName, BinaryResultName);
end

function traverse(Input, NonoiseResultName, BinaryResultName)
idsInput = dir(Input);
    for i = 1:length(idsInput)
        if idsInput(i, 1).name(1)=='.'
            continue;
        end
        if idsInput(i, 1).isdir==1
            if ~isdir(strcat(NonoiseResultName, idsInput(i, 1).name, '/'));
                mkdir(strcat(NonoiseResultName, idsInput(i, 1). name, '/'));
            end
            if ~isdir(strcat(BinaryResultName, idsInput(i, 1).name, '/'));
                mkdir(strcat(BinaryResultName, idsInput(i, 1). name, '/'));
            end
            traverse(strcat(Input, idsInput(i, 1).name, '/'), strcat(NonoiseResultName, idsInput(i, 1).name, '/'), strcat(BinaryResultName, idsInput(i, 1).name, '/'));
        else
            if strcmp(idsInput(i, 1).name((end-2):end), 'png' ) 
                imgfile = fullfile(Input, idsInput(i, 1).name);
                img = imread(imgfile);
                img = 255-img;
                imgbw = im2bw(img,3/255);
                L = bwareaopen(imgbw, 5);
                result = double(img) .* double(L);
                img5 = uint8(255-result);
                imwrite(img5, strcat(NonoiseResultName, idsInput(i, 1).name(1: (end-4)), '.png'));
                imwrite(L, strcat(BinaryResultName, idsInput(i, 1).name(1: (end-4)), '.png'));
            end
        end
    end
end
