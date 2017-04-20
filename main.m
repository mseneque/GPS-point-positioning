%function [ sat, year, month, day, hour, min, second, SVclockBias, SVclockDrift, SVclockDriftRate, IODE, crsM, delta_n, m0, cuc, e, cus, sqrtA, TToE, cic, OMEGA, CIS, i0, crc, omega, OMEGADOT, IDOT, codesL2, GPSweek, SVaccuracy, SVhealth, TGD, IODC, transTime, unknownData ] = readNavigationFile( navFile )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

clear
format long g

% Approximate reference X,Y,Z coordinates
approxXr = -2363868; 
approxYr = 4870331; 
approxZr = -3360984;

[ sat, IODE, Crs, delta_n, m0, Cuc, e, Cus, sqrtA, Toe, Cic, OMEGA, Cis, i0, Crc, omega, OMEGADOT, iDOT, GPSweek, entry, T ] = readNavigationFile('00261671.09N');

[ observedCodeData ] = readObservationFile();

[ Xk, Yk, Zk ] = satPosition( Toe, GPSweek, m0, sqrtA, delta_n, e, omega, Cuc, Cus, Crc, Crs, Cic, Cis, i0, iDOT, OMEGA, OMEGADOT, T, entry );

[ epochNum ] = epochDetermination( T, Toe );

[ elevAngle, east, north, up ] =  elevationAngle( Xk, Yk, Zk, approxXr, approxYr, approxZr) ;

[ codeData, elevAngle, Xk, Yk, Zk, sat ] = obsFilter( elevAngle, Xk, Yk, Zk, sat, epochNum, observedCodeData )

[ A, p ] = designMatrixA( Xk, Yk, Zk, approxXr, approxYr, approxZr )

[ W, errorConst ] = covarMatrixQ( elevAngle )

[ M ] = miscloseMatrixM( p, codeData )

[ correction, XYZsolution, standardDev ] = leastSquares( A, W, M, approxXr, approxYr, approxZr, errorConst )

%[ vt ] = satPosition1( sqrtA, T, Toe, e, delta_n, m0, entry  );

%[ phi, phiRAD, lambda, lambdaRAD, h ] = xyz2geodetic( xyz, entry );

%[ delta_xyz, distGround2Sat ] = elevationAngle( xyz, phi, phiRAD, lambda, lambdaRAD, h, entry );

