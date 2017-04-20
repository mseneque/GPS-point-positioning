function [ phi, phiRAD, lambda, lambdaRAD, h ] = xyz2geodetic( xyz, entry );
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

x=1; y=2; z=3

a = 6378137
b = 6356752.314245

e2 = (a^2-b^2)/a^2
ecc2 = (a^2-b^2)/b^2

% %dummy vals
% entry = 1
% xyz(1,x) = 4210520.621
% xyz(1,y) = 1128205.600
% xyz(1,z) = 4643227.495

for n = 1:entry
    rho(n) = sqrt(xyz(n,x)^2+xyz(n,y)^2)
    theta(n) = atan2((xyz(n,z)*a),(rho(n)*b))
        
    phiRAD(n) = atan2((xyz(n,z)+ecc2*b*sin(theta(n))^3),(rho(n)-e2*a*cos(theta(n))^3))
    phi(n) = 180/pi*phiRAD(n)
    
    lambdaRAD(n) = atan2(xyz(n,y),xyz(n,x))
    lambda(n) = 180/pi*lambdaRAD(n)
    
    
    N(n) = a^2/sqrt(a^2*cos(phiRAD(n))^2+b^2*sin(phiRAD(n))^2)
    
    h(n) = (rho(n)/cos(phiRAD(n))) - N(n)
end