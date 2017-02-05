function result = BoundingBox(imgfile)
img=imread(imgfile);
img_r=img(:,:,1);
[m, n]=size(img_r);
flag = 0;
for i = 1:m-12
    for j = 1:n-12
        if img_r(i, j)<=2&&img_r(i, j+1)<=2&&img_r(i, j+2)<=2&&img_r(i, j+3)<=2&&img_r(i, j+4)<=2....
                &&img_r(i, j+5)<=2&&img_r(i, j+6)<=2&&img_r(i, j+7)<=2&&img_r(i, j+8)<=2&&img_r(i, j+9)<=2....
                &&img_r(i, j+10)<=2&&img_r(i, j+11)~=0....
                &&img_r(i+1, j)<=2&&img_r(i+2, j)<=2&&img_r(i+3, j)<=2&&img_r(i+4, j)<=2....
                &&img_r(i+5, j)<=2&&img_r(i+6, j)<=2&&img_r(i+7, j)<=2&&img_r(i+8, j)<=2....
                &&img_r(i+9, j)<=2&&img_r(i+10, j)<=2&&img_r(i+11, j)~=0&&img_r(i+1, j+1)~=0
            l1 = i;
            w1 = j;
            flag = 1;
            break;
        end
    end
    if flag == 1
        break;
    end
end
flag = 0;
for i = m:-1:12
    for j = n:-1:12
        if img_r(i, j)<=2&&img_r(i, j-1)<=2&&img_r(i, j-2)<=2&&img_r(i, j-3)<=2&&img_r(i, j-4)<=2....
                &&img_r(i, j-5)<=2&&img_r(i, j-6)<=2&&img_r(i, j-7)<=2&&img_r(i, j-8)<=2&&img_r(i, j-9)<=2....
                &&img_r(i, j-10)<=2&&img_r(i, j-11)~=0....
                &&img_r(i-1, j)<=2&&img_r(i-2, j)<=2&&img_r(i-3, j)<=2&&img_r(i-4, j)<=2....
                &&img_r(i-5, j)<=2&&img_r(i-6, j)<=2&&img_r(i-7, j)<=2&&img_r(i-8, j)<=2....
                &&img_r(i-9, j)<=2&&img_r(i-10, j)<=2&&img_r(i-11, j)~=0&&img_r(i-1, j-1)~=0
            l2 = i;
            w2 = j;
            flag = 1;
            break;
        end
    end
    if flag == 1
        break;
    end
end
result=img_r(l1:l2, w1:w2);