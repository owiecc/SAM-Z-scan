%function [ roi ] = regionOfInterest( zData )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x = 1:20:250;
y = 1:20:250;

sx = reshape(zData(:,x,y),15008,numel(x)*numel(y)); 
sx(sx<3) = 0; %remove noise
sz = sum(abs(sx),2)>0;

roi = find(sz,1,'first')-200:1:find(sz,1,'last')+200;

%end