function [ roi ] = regionOfInterest( zData )
%regionOfInterest Finds part of zScan with actual data
%   ROI = regionOfInterest(zData) analyses a subset of Z scan to detect 
%   the presence of echo. Returns ROI index to be used in zData(ROI[],x,y).

% get 0.5% of xy scan area
nAScans = round(size(zData,2)*size(zData,3)/200); 
xy = randi(size(zData,2)*size(zData,3),nAScans,1);

% get subset od zData
sx = zData(:,xy); 

%remove noise
sx(sx<3) = 0; 

% create logical vector if signal present
sz = sum(abs(sx),2) > 0;

% find region of interest boundary (data > noise exist there)
% right now works well with single echo. will not work good with double
% echo. fix this /// TODO
roiExpand = 200;
roiFirst = max(find(sz,1,'first') - roiExpand, 1);
roiLast = min(find(sz,1,'last') + roiExpand, size(zData,1));
roi = roiFirst:1:roiLast;

end