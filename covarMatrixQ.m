function [ W, errorConst ] = covarMatrixQ( elevAngle )
% This is an elevation-angle-dependent stochastic model. This will work for
% single observations at the first observed epoch.
% W Design Matrix is calculated 
% A, M, (W)

% constants
errorConst = 0.5;  %0.5m set for code observations

% Weight Matrix
Q = diag((1./sin(elevAngle)*errorConst).^2);
W = Q^-1

    

