function [Cs]=boundary_extract_binary(im)
%imshow(im);
 %c= contourc(im);
c		= contourc(im,[.8 .8]);%在轮廓上提取部分点（不是全部）
%c= imcontour(im);%提取轮廓的坐标
len_c	= size(c,2);%列数 1表示行数，2表示列数

if len_c>0
	n_max	= length(find(c(1,:)==.8));
	Cs		= cell(n_max,1);
	n_C		= 0;
	iHead	= 1;
	while iHead<len_c
		n_len	= c(2,iHead);%1127
		iTail	= iHead+n_len;%1128
		n_C		= n_C+1;
		Cs{n_C}	= c(:,iHead+1:iTail);
		iHead	= iTail+1;
	
		if 0	% test
			figure;	clf;
			imshow(im);	hold on;
			plot(Cs{n_C}(1,:), Cs{n_C}(2,:),'b');
			pause;
		end
	end
	
	if n_C<n_max
		Cs	= Cs(1:n_C);
	end
	
else
	Cs	= [];
end

