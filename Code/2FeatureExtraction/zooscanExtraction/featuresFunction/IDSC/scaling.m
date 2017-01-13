function [scaledface] = scaling( faceMat,lowvec,upvec )
%特征数据规范化
%输入——faceMat需要进行规范化的图像数据，
%       lowvec原来的最小值
%       upvec原来的最大值
upnew=1;
lownew=-1;
[m,n]=size(faceMat);
scaledface=zeros(m,n);
for i=1:m
    scaledface(i,:)=lownew+(faceMat(i,:)-lowvec)./(upvec-lowvec)*(upnew-lownew);
end
end