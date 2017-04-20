function [ codeData, elevAngle, Xk, Yk, Zk, sat ] = obsFilter( elevAngle, Xk, Yk, Zk, sat, epochNum, observedCodeData )
% This module is aimed at filtering the observation data to that which
% meets the observation criterior. This is obs angle greater than 15
% degrees, and observations taken from the first epoch from the data.

% store the variables to temporary versions
tempElevAngle = elevAngle
tempXk = Xk
tempYk = Yk
tempZk = Zk
tempSat = sat

% Start with clearing the variables to filter
count=0; elevAngle=0; Xk=0; Yk=0; Zk=0; sat=0;


% Elevation angles that are suitable for use in calculation of the
% stockastic model. The criterior is that the angles are from 1st epoch, 
% observations are over 15 degrees and observed satellite code measurment.
for n = 1:length(tempElevAngle)
    %Selection criterior
    if epochNum(n) == 1 & tempElevAngle(n) > (15/180*pi())  
        for cc = 1:length(observedCodeData)
            if tempSat(n) == observedCodeData(cc,1)
                 count = count + 1
                 codeData(count,:) = observedCodeData(cc,:) 
                 elevAngle(count) = tempElevAngle(n)
                 Xk(count) = tempXk(n)
                 Yk(count) = tempYk(n)
                 Zk(count) = tempZk(n)
                 sat(count) = tempSat(n)              
            end
        end
    end
end