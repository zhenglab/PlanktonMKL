/*
% function [E] = build_graph_contour_C(X,Y,fg_mask,bSmoothCont)
% 	Initialize the graph from contour points
%		for each p1
%			for each p2
%				if (p1,p2) inside the shape
%					add edge e(p1,p2) into E
%					set dis_mat(p1,p2)=dis_mat(p2,p1)
%					set ang_mat(p1,p2), ang_mat(p2,p1)
%					set viewable(p1,p2)=viewable(p2,p1)=1

% Author	:	Haibin Ling, hbling AT umiacs.umd.edu
%				Computer Science Department, University of Maryland, College Park
*/

/* common functions */
#include "mex.h"
#include "common_matlab.h"

void build_graph_contour(double *E, int &n_E,
						 double *fg_mask, int nRow, int nCol,
						 int *X, int *Y, int n_V,
						 bool	bSmoothCont=0
						 );


/* Macros */
#define NEW_EDGE(E,n_E,p1,p2,dis)	{\
					MAT_SET(E, n_E, 0, p1, 3);\
					MAT_SET(E, n_E, 1, p2, 3);\
					MAT_SET(E, n_E, 2, dis,3);\
		}
//#define MAT_GET(pMat,x,y,nRow)		pMat[(x)*(nRow)+(y)]
//#define MAT_SET(pMat,x,y,val,nRow)	pMat[(x)*(nRow)+(y)]=(val)

bool	bDebug	= 1;
int		iDebug	= 0;


/*-----------------------------------------------------------------------------*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
    // Prepare for the data
	double	*pX		= mxGetPr(prhs[0]);//prhs[0]指向X，轮廓点的横坐标
	double	*pY		= mxGetPr(prhs[1]);//prhs[1]指向Y，轮廓点的纵坐标
	int		n_V		= mxGetM(prhs[0]);//获取矩阵的行数  mxGetN获取矩阵的列数

	
	double	*fg_mask= mxGetPr(prhs[2]);//prhs[2]图像矩阵
	int		nRow	= mxGetM(prhs[2]);//读取图像矩阵的行数
	int		nCol	= mxGetN(prhs[2]);//读取图像矩阵的列数

	bool	bSmoothCont	= 0;
	if(nrhs>3)
		bSmoothCont	= (*mxGetPr(prhs[3])) > .5;


	// Initialization
	int *X	= new int[n_V];//n_V点数100
	int	*Y	= new int[n_V];
	for(int i=0; i<n_V; i++) {
		X[i]= ROUND(pX[i]); //返回四舍五入的值，轮廓点的横坐标
		Y[i]= ROUND(pY[i]);//返回四舍五入的值，轮廓点的纵坐标
	}


	/* build the graph */
	double *E	= new double[3*n_V*n_V];	// locate memory for edge list
	int		n_E;
	build_graph_contour(E, n_E,
						fg_mask, nRow, nCol,
						X, Y, n_V,
						bSmoothCont
						);



    /* output matrices */
    mxArray *pMxE	= mxCreateDoubleMatrix(3,n_E,mxREAL);
    double	*pE		= mxGetPr(pMxE);
	memcpy(pE,E,3*n_E*sizeof(double));		// truncate if necessary
    plhs[0] = pMxE;

	delete []Y;
	delete []X;
	delete []E;
}



/*-------------------------------------------------------------------------------*/

void build_graph_contour(double *E, int &n_E,
						 double *fg_mask, int nRow, int nCol,
						 int *X, int *Y, int n_V,
						 bool	bSmoothCont
						 )
{
	/*
	dis_mat		= inf*ones(n_V,n_V);	% each COLUMN is a record at a point
	ang_mat		= inf*ones(n_V,n_V);
	viewable	= zeros(n_V,n_V);
	*/
	int		x1,y1,x2,y2,dx,dy,n,k;
	int		p1,p2;
	bool	bIn	= false;
	double	deltaX,deltaY,x,y;
	double	dis;
	n_E		= 0;
	for(p1=0;p1<n_V;++p1)
	{
		x1	= X[p1]-1;
		y1	= Y[p1]-1;
		for(p2=p1+1;p2<n_V;++p2)
		{
			x2	= X[p2]-1;
			y2	= Y[p2]-1;
			dx	= x2-x1;//两点横坐标之差
			dy	= y2-y1;//两点纵坐标之差

			// test if (p1,p2) inside the shape
			bIn	= true;
			n	= MAX(abs(dx),abs(dy));

			if(bSmoothCont && (p2==p1+1 || p2-p1==n_V-1))//该点左右两边的点一定在轮廓内部
			{
				bIn	= true;
				//printf("bIn\n");
			}

//？？判断是否落在轮廓内部
			else if(n>2)
			{
				deltaX	= ((double)dx)/n;
				deltaY	= ((double)dy)/n;
				x		= x1;
				y		= y1;
				for(k=0;bIn && k<n-1;k++)
				{
					x	+= deltaX;
					y	+= deltaY;
					if( MAT_GET(fg_mask,ROUND(x),ROUND(y),nRow) < .5 )//??
						bIn	= false;
				}
			}
			// if inside, set dis_mat, ang_mat, viewable
			if(bIn)
			{
				// adding edge
				dis		= sqrt((double)(dx*dx+dy*dy));
				NEW_EDGE(E,n_E, (double)(p1+1),(double)(p2+1),dis);				
				n_E++;
			}
		}// of p2
	}//of p1
}
