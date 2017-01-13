function [cont] = extract_longest_cont(im, n_contsamp)
	%- Extract contour, count only the longest contours
    [Cs]	= boundary_extract_binary(im); %提取轮廓
%     	X	= Cs{1}(1,:);  %画出提取的点
% 	Y	= Cs{1}(2,:);
%   plot(X,Y,'b.');
%       	X	= Cs{2}(1,:);  %画出提取的点
% 	Y	= Cs{2}(2,:);
%   plot(X,Y,'b.');
%     	X	= Cs{3}(1,:);  %画出提取的点
% 	Y	= Cs{3}(2,:);
%   plot(X,Y,'b.');

    n_max	= 0;
    i_max	= 0;
    for cc=1:length(Cs)
        if size(Cs{cc},2)>n_max
            n_max = size(Cs{cc},2);
            i_max = cc;
        end
    end
    cont	= Cs{i_max}';
            
    % remove redundant point in contours 去掉多余的点,根据差值
    cont		= [cont; cont(1,:)];
    dif_cont	= abs(diff(cont,1,1));
    id_gd		= find(sum(dif_cont,2)>0.001);
    cont		= cont(id_gd,:);
            
    % force the contour to be anti-clockwisecomputed above is at the different orientation
    bClock		= is_clockwise(cont,im);
    if bClock	cont	= flipud(cont);		%flipud矩阵上下翻转
    end
            
    % start from bottom
    [min_v,id]	= min(cont(:,2));%min找出最小值，并返回最小值min_v，和坐标id
    cont		= circshift(cont,[length(cont)-id+1]);%circshift循环平移
            
	[XIs,YIs]	= uniform_interp(cont(:,1),cont(:,2),n_contsamp-1);%选取轮廓上100个点,点的坐标
	cont		= [cont(1,:); [XIs YIs]];%第一个点的坐标和剩下所有点的坐标
