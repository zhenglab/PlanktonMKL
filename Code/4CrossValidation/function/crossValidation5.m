function [bestc, bestg] = crossValidation5(features,trainLabel,resultName)

cmin = -10;
cmax = 10;
gmin = -10;
gmax = 10;
v = 5; % 交叉验证折数

train_target = trainLabel;
train_data = features;

kernel = 2;
[bestCVaccuracy,bestc,bestg] = SVMcgForClass(train_target,train_data,kernel,cmin,cmax,gmin,gmax,v);
resultMatrix(1,:) = [kernel, bestCVaccuracy, bestc, bestg]; 

fid = fopen(resultName,'w');
fprintf(fid,'%f\t%f\t%f\t%f\n',resultMatrix(1,:));
fclose(fid);