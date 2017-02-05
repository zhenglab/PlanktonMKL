function match_cost=comIDSC(imgBinaryTestLarge,imgBinaryTrain)

%------ Parameters ----------------------------------------------
ifig		= 1;
% sIms		= {'01_01_m.bmp', '01_04_m.bmp'};

%-- shape context parameters
n_dist		= 5;
n_theta		= 12;
bTangent	= 1;
bSmoothCont	= 1;
n_contsamp	= 100; %取100个采样点

ims{1} = double(imgBinaryTestLarge);
ims{2} = double(imgBinaryTrain);
%-- Extract inner-distance shape context
for k=1:2
	
	%- Contour extraction
% 	ims{k}	= double(imread(sIms{k})); %读取图像
	Cs{k}	= extract_longest_cont(ims{k}, n_contsamp);%提取轮廓点集，Cs存放提取的点坐标的位置
	%- inner-dist shape context
	msk		= ims{k};%>.5;表示图像的矩阵
	[sc,V,E,dis_mat,ang_mat] = compu_contour_innerdist_SC(Cs{k},msk,n_dist, n_theta, bTangent, bSmoothCont,0);%计算内部距离
	scs{k}	= sc;
	
end


%-- compute SC distance b/w sc1 and sc2 and cost matrix
[dis_sc,costmat]	= dist_bw_sc_C( scs{1},scs{2}, 0);%代价矩阵

%-- MATCHING  进行匹配
n_match		= 1;
num_start			= round(n_contsamp);
search_step			= 1;
thre				= .6;
[cvec,match_cost]	= DPMatching_C(costmat,thre,num_start,search_step);%动态规划进行匹配


%-- point correspondences for computation of  对应点的估计
n_pt		= size(scs{1},2);
id_gd1		= find(cvec<=n_pt);
id_gd2		= cvec(id_gd1);
pt_from		= Cs{1}(id_gd1,:);
pt_to		= Cs{2}(id_gd2,:);
n_match		= length(pt_from);


return;
