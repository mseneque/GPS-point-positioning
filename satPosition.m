function [ Xk, Yk, Zk ] = satPosition( Toe, GPSweek, m0, sqrtA, delta_n, e, omega, Cuc, Cus, Crc, Crs, Cic, Cis, i0, iDOT, OMEGA, OMEGADOT, T, entry );
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

%constants
    gc = +3.986008D+14;
    earthRotateRate = +7.292115147D-5;

% computed mean motion (rad/sec)
    n0 = sqrt(gc)./(sqrtA.^3)

% time from ephemeris reference epoch
    tk  = T-Toe; 
    
% corrected mean motion
    n = n0 + delta_n
    
% mean anomaly
    mk = m0 + n.*tk 
    mk = rem(mk+2*pi,2*pi)
    
% Keplers equation for eccentric anomaly
% Itterativley solve for Ek
    repeat = 10;
    Ek = mk;
    for temp = 1:repeat;
        Ek = mk + e .* sin(Ek);
    end
    Ek = rem(Ek+2*pi,2*pi)
    
% True anomaly
    fk = atan2((sqrt(1-e.^2).*sin(Ek)),(cos(Ek)-e));
    fk1 = acos((cos(Ek)-e)./(1-e.*cos(Ek)));
    
% eccentricity anomaly
    Ek = acos((e+cos(fk))./(1+e.*cos(fk)));
    Ek = rem(Ek+2*pi,2*pi)
    
% Argument of latitude
    phi_k = fk + omega             % + Cuc.*cos(2*(omega+fk))+Cus.*sin(2*(omega+fk));
    phi_k = rem(phi_k+2*pi,2*pi)
     
% Second harmonic perbutaions    
        % Argument of latitude correction
            delta_uk = Cus.*sin(2*(phi_k)) + Cuc.*cos(2*(phi_k))
        % Radius corrections
            delta_rk = Crc.*cos(2*(phi_k)) + Crs.*sin(2*(phi_k))
        % Correction to inclination
            delta_ik = Cic .* cos(2*(phi_k)) +  Cis .* sin(2*(phi_k))

% Corrected argument of latitude
    uk = phi_k + delta_uk
    uk = rem(uk+2*pi,2*pi)
    
% Corrected radius
    rk = sqrtA.^2 .* (1-e.*cos(Ek)) + delta_rk
    
    
% Corrected inclination
    ik = i0 + delta_ik + (iDOT).*tk
    ik = rem(ik+2*pi,2*pi)
    
% Positions in orbital plane
    X_pln = rk.*cos(uk) 
    Y_pln = rk.*sin(uk)
    
% Corrected longitude of ascending node
    OMEGA_k = OMEGA + (OMEGADOT - earthRotateRate) .* tk - earthRotateRate*Toe

% EARTH FIXED COORDINATES OF SATELLITE

    Xk = (X_pln) .* cos(OMEGA_k) - (Y_pln) .* cos(ik) .* sin(OMEGA_k)
    Yk = (X_pln) .* sin(OMEGA_k) + (Y_pln) .* cos(ik) .* cos(OMEGA_k)
    Zk = (Y_pln) .* sin(ik)


    

