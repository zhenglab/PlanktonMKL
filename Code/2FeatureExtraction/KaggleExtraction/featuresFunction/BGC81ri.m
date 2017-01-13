function [h] = BGC81ri(X)

%BGC81ri texture features
%
%INPUT:
%X: grey-scale image
%
%OUTPUT:
%h:     featureVector
%

    % Image size
    [L M] = size(X);

    Xcod = codeBGC81(X);
    histCodesBGC81 = sum(hist(Xcod,0:255)');

    lut81 = lutRotInv('LBP81ri');

    nbins = length(unique(lut81));

    histCodesBGC81ri = zeros(1,nbins);

    for p = 1:length(histCodesBGC81);
        r = lut81(p);
        histCodesBGC81ri(r+1) =  histCodesBGC81ri(r+1) + histCodesBGC81(p);
    end

    h  =  histCodesBGC81ri / ((L-2)*(M-2));

end

function [Xcod] = codeBGC81(X)
%
% [Xcod] = codeBGC81(X)
% 
% Computes BGC81 codes of a single channel texture image
%
% Inputs:
%   X    -  Single channel texture image (at least 3x3 pixels)
%
% Outputs:
%   Xcod  -  Matrix with BGC81 codes


    % Coeficients used in bilinear interpolation
    sqrt_2 = 1.4142; 
    center  =  (1-1/sqrt_2)^2;
    corner  =  (1/sqrt_2)^2;
    diagon  =  (1-1/sqrt_2)*(1/sqrt_2);

    % Conversion to avoid errors when using sort, unique...
    X = double(X);

    % Image size
    [L M] = size(X);

    % Displacement directions
    north = 1:L;   % N: North
    south = 3:L+2; % S: South
    equad = 2:L+1; % equator
    east  = 3:M+2; % E: East
    west  = 1:M;   % W: West
    meri  = 2:M+1; % meridian
    % 0: No displacement

    X0 = zeros(L+2,M+2);
    X0(equad,meri) = X;

    [XN, XNE, XE, XSE, XS, XSW, XNW, XW]     = deal(zeros(L+2,M+2));

    [pN, pNE, pE, pSE, pS, pSW, pW, pNW, p0] = deal(zeros(L+2,M+2));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pN (north,meri) = diagon*X ;
    pS (south,meri) = diagon*X ;
    pE (equad,east) = diagon*X ;
    pW (equad,west) = diagon*X ;

    pNE(north,east) = X ;
    pNW(north,west) = X ;
    pSE(south,east) = X ;
    pSW(south,west) = X ;

    p0 (equad,meri) = center*X ;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    XN(north,meri) = X;
    XS(south,meri) = X;
    XE(equad,east) = X;
    XW(equad,west) = X;

    %--round-- not present in the oroginal code -- inserted by Francesco
    XSE = round(corner*pSE + pS + pE + p0);
    XSW = round(corner*pSW + pS + pW + p0);
    XNW = round(corner*pNW + pN + pW + p0);
    XNE = round(corner*pNE + pN + pE + p0);

    %X0 = 128*(XSE>=X0)+64*(XS>=X0)+32*(XSW>=X0)+16*(XW>=X0)+8*(XNW>=X0)+4*(XN>=X0)+2*(XNE>=X0)+(XE>=X0);
    X0 = 128*(XSE>=XS)+64*(XS>=XSW)+32*(XSW>=XW)+16*(XW>=XNW)+8*(XNW>=XN)+4*(XN>=XNE)+2*(XNE>=XE)+(XE>=XSE);

    %Original code
    Xcod = X0(3:L,3:M);

end