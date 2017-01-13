function writeData(confMatrix, txtName)
fid = fopen(txtName, 'wt');
[m, n] = size(confMatrix);
for i = 1:m
    total_row = sum(confMatrix(i, :));
    recall(i) = confMatrix(i, i)/(total_row+eps);
    precision(i) = (sum(confMatrix(:, i))-confMatrix(i, i))/(sum(confMatrix(:, i))+eps);
    for j = 1:n
        if j == n
            fprintf(fid, '%f\t%f\t%f\t%f\n', confMatrix(i, j), total_row, recall(i), precision(i));
        else
            fprintf(fid, '%f\t', confMatrix(i, j));
        end
    end
end
for k = 1:n
    total_col = sum(confMatrix(:, k));
    fprintf(fid, '%f\t', total_col);
end
fprintf(fid, '%f\t%f\t%f', sum(confMatrix(:)), mean(recall), mean(precision));
fclose(fid);