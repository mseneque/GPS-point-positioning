function [ observedCodeData ] = readObservationFile();
% UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here


% Manual input of code data to GPS satellite number at matching epoch from 
% observation file.
observedCodeData(1,:) = [16; 30; 10; 21; 31; 24; 29; 12; 18];
observedCodeData(2,:) = [23691085.195; 21552320.336; 24392837.688; 19856204.172; 22348646.703; 20962514.727; 21117385.070; 24477648.133; 23298915.578];
observedCodeData = observedCodeData'