function result = square_fill(imgfile)
img=imread(imgfile);
[m, n]=size(img);
img(1, 1:11) = 255;
img(1:11, 1) = 255;
img((m-10):m, n) = 255;
img(m, (n-10):n) = 255;
if m > n
    tmp = floor((m-n)/2);
    tmpMatrix = zeros(m, m);
    tmpMatrix(:, 1:tmp) = 255;
    tmpMatrix(:, (tmp+1):(tmp+n)) = img;
    tmpMatrix(:, (tmp+n+1):m) = 255;
    result = tmpMatrix;
else if n > m
        tmp = floor((n-m)/2);
        tmpMatrix = zeros(n, n);
        tmpMatrix(1:tmp, :) = 255;
        tmpMatrix((tmp+1):(tmp+m), :) = img;
        tmpMatrix((tmp+m+1):n, :) = 255;
        result = tmpMatrix;
    else
        result = img;
    end
end