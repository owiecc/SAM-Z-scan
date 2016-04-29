function [ aScan ] = getAScan( zData,x,y )
%getAScan Summary of this function goes here
%   Detailed explanation goes here
aScan = double(zData(:,x,y));
end