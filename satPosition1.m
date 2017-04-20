function [ vt ] = satPosition1( sqrtA, t, Toe, e, delta_n, m0, entry );

%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

% e = 0.1; Toe = 0; t = 10800; Mt = pi/2

% Gravity constant between satellites and the Earth (u)
u = +3986004.418D+8

% Mean angular velocity (n)
n = ( sqrt(u)./sqrtA.^3 ) + delta_n


%% ----------------------------------- %%
%   Calculation of Keplerian orbit      %
%            Anomalies                  %

% Mean anomaly
Mt = m0 + n.*(t-Toe)
Mt = rem(Mt+2*pi,2*pi)

% Eccentric anomaly
repeat = 10;
Et = Mt;
for temp = 1:repeat;
    Et = Mt + e.*sin(Et)
end
Et = rem(Et+2*pi,2*pi)
Et_DEG = 180/pi * Et

% True anomaly 
%               This is the angle from the perigee
%               on the plane that the satellite is positioned.
vt = 2*atan(sqrt((1+e)./(1-e)).*(tan(Et./2)))
vt_DEG = 180/pi * vt

%%-------------------------------------%%
% Orbit plane representation            %
%                                       %

% r value
r = (sqrtA.^2).*(1-e.*cos(Et));
% position vector r
for inc = 1:entry
    r_posVect(:,inc) = r(inc) * [ cos(vt(inc)); sin(vt(inc)) ]
end

% rDOT value

% velocity vector rDOT
temp = sqrt(u./(sqrtA.^2.*(1-e.^2))) 

for inc = 1:entry 
    rDOT_velVect(:,inc) = temp(inc) * [-sin(vt(inc)); cos(vt(inc))+e(inc)] 
end    

% Rotation Matrix

R = [ (cos(OMEGA)*cos(omega)




