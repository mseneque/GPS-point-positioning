function [ east, north, up ] =  satCoords2localGrid( Xk, Yk, Zk, X_ref, Y_ref, Z_ref)
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here


phiP = atan2(Z_ref, sqrt(X_ref^2 + Y_ref^2));
lambda = atan2(Y_ref,X_ref);

east = -sin(lambda) .* (Xk - X_ref) + cos(lambda) .* (Yk - Y_ref);
north = -sin(phiP) .* cos(lambda) .* (Xk - X_ref) - sin(phiP) .* sin(lambda) .* (Yk - Y_ref) + cos(phiP) .* (Zk - Z_ref);
up = cos(phiP).*cos(lambda).*(Xk - X_ref) + cos(phiP).*sin(lambda).*(Yk - Y_ref) + sin(phiP).*(Zk - Z_ref);

up = abs(up)

elevAngle = atan2(up,sqrt(east.^2 + north.^2));
elevAngleDEG = 180/pi * elevAngle;