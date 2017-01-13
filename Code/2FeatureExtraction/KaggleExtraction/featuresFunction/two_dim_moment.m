function fai=two_dim_moment(img)
    [m n]=size(img);
    img=double(img);
    
    %图像的各阶矩
    mm=zeros(4,4);   
    for y=1:m
        for x=1:n           
            for q=1:4
                for p=1:4
                    mm(q,p)=mm(q,p)+x^(p-1)*y^(q-1)*img(y,x);
                end
            end
        end
    end
    mean_x=mm(2,1)/mm(1,1);
    mean_y=mm(1,2)/mm(1,1);
    
    %三阶中心矩
    u00=mm(1,1);
    u11=mm(2,2)-mean_y*mm(2,1);
    u20=mm(3,1)-mean_x*mm(2,1);
    u02=mm(1,3)-mean_y*mm(1,2);
    u30=mm(4,1)-3*mean_x*mm(3,1)+2*mean_x^2*mm(2,1);
    u03=mm(1,4)-3*mean_y*mm(1,3)+2*mean_y^2*mm(1,2);
    u21=mm(3,2)-2*mean_x*mm(2,2)-mean_y*mm(3,1)+2*mean_x^2*mm(1,2);
    u12=mm(2,3)-2*mean_y*mm(2,2)-mean_x*mm(1,3)+2*mean_y^2*mm(2,1);
    %归一化中心矩
    n20=u20/u00^2;
    n02=u02/u00^2;
    n11=u11/u00^2;
    n30=u30/u00^2.5;
    n03=u03/u00^2.5;
    n12=u12/u00^2.5;
    n21=u21/u00^2.5;
    
    %7个不变矩
    fai(1) = n20 + n02; 
    fai(2) = (n20-n02)^2 + 4*n11^2;
    fai(3) = (n30-3*n12)^2 + (3*n21-n03)^2; 
    fai(4) = (n30+n12)^2 + (n21+n03)^2;
    fai(5) = (n30-3*n12)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n21-n03)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
    fai(6) = (n20-n02)*((n30+n12)^2-(n21+n03)^2)+4*n11*(n30+n12)*(n21+n03);
    fai(7) = (3*n21-n03)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n12-n30)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
    
end