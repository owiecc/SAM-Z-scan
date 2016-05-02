function [ firstInterface ] = detectFirstInterface( zData )
%detectFirstInterface Finds the position of the first interface
%   Detailed explanation goes here

xSize = size(zData,2);
ySize = size(zData,3);

firstInterface = zeros(xSize,ySize);

for ix = 1:xSize
  for iy = 1:ySize
    AScan = getAScan(zData,ix,iy);    
    firstPeak = min(find(abs(AScan)>10,1));    
    
%     idxPeaksPos = peakSeek(diff(AScan),5,5);
%     idxPeaksNeg = peakSeek(-diff(AScan),5,5);
%     firstPeak = min([idxPeaksPos(:); idxPeaksNeg(:)]);

    if isempty(firstPeak)
      firstPeak = NaN; % = 1
    end
    firstInterface(ix,iy) = firstPeak; % zData(firstPeak,ix,iy);
  end
end

% firstInterface(firstInterface==1)=NaN;

end

%% 
% 2s with zData > 10 
% 48s with for + peakSeek
% 270s with parfor / 2 workers + findpeek
% 319s with parfor / 4 workers + findpeek
