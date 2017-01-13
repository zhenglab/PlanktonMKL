function [XIs,YIs] = uniform_interp(Xs,Ys,n_samp)%轮廓的横纵坐标，和要提取的点数

% 	% test
% 	Xs		= (1:10)';
% 	Ys		= [3 4 12 4 3 5 6 12 2 9]';
% 	n_samp	= 11;
	
	XIs		= zeros(n_samp,1);
	YIs		= zeros(n_samp,1);
	
	len_all	= 0;
	difXs	= diff(Xs);%求轮廓点横坐标间的差商
	difYs	= diff(Ys);
	seg_lens	= [0; sqrt(difXs.^2+difYs.^2)];%轮廓点间的距离
	len_all	= sum(seg_lens);%轮廓线的长度
	d_len	= len_all/(n_samp+1);%将轮廓线的长度划分为100份，每一份的长度
	
	% interpolate to get each point
	n_pt	= length(Xs);%轮廓上点的个数1126
	for(ii=2:n_pt)
		seg_lens(ii)	= seg_lens(ii)+seg_lens(ii-1);%计算每一点与起始点轮廓间的长度
	end
	
	i_fill	= 0;
	cur_len	= d_len;
	for(ii=2:n_pt)%采用在轮廓边缘上间隔一定的距离（边缘长度的1/100），取一个点
		while cur_len <= seg_lens(ii)  & i_fill<n_samp
			% interpolate a point 插入点
			r	= (cur_len-seg_lens(ii-1)) / (seg_lens(ii)-seg_lens(ii-1));%所取点的坐标的确定
			x	= Xs(ii-1)+r*(Xs(ii)-Xs(ii-1));%所取点的坐标的确定
			y	= Ys(ii-1)+r*(Ys(ii)-Ys(ii-1));%所取点的坐标的确定
			i_fill	= i_fill+1;
			XIs(i_fill)	= x;
			YIs(i_fill)	= y;
			cur_len	= cur_len+d_len;
		end
	end
	
	% test
    
	if 0
		figure(97);	clf; hold on;
		plot(Xs,Ys,'r.-');
		plot(XIs,YIs,'b+');
		title(['n_samp=' i2s(n_samp) ', len=' i2s(length(XIs))]);
		keyboard;
	end
