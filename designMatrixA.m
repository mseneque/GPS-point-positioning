function [ A, p ] = designMatrixA( Xk, Yk, Zk, X0, Y0, Z0 )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

% Light constant 
c = 2.99792458*10^8

% Creation of design matrix A, for each row of filtered observations and
% partial derivativs.
for i = 1:length(Xk)
    
    p(i) = sqrt((Xk(i)-X0)^2 + (Yk(i)-Y0)^2 + (Zk(i)-Z0)^2);
    
    A(i,1) = -(Xk(i) - X0) / p(i);
    A(i,2) = -(Yk(i) - Y0) / p(i);
    A(i,3) = -(Zk(i) - Z0) / p(i);
    A(i,4) = c;
end