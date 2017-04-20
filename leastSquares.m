function [ correction, XYZsolution, standardDev ] = leastSquares( A, W, M, X0, Y0, Z0, errorConst )
%  UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

correction = -(A'*W*A)^-1 * A'*W*M

XYZsolution = correction(1:3,1)+ [[X0]; [Y0]; [Z0]]

covarSolution = -(errorConst)^2 * (A'*W*A)^-1

% Standard deviation of the X,Y,Z,dT solution.
standardDev = sqrt(abs(diag(covarSolution)))