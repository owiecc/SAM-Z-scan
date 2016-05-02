function [ firstInterface ] = detectFirstInterface( zData )
%detectFirstInterface Finds the position of the first interface
%   Detailed explanation goes here

xSize = size(zData,2);
ySize = size(zData,3);

firstInterface = zeros(xSize,ySize);

parfor ix = 1:xSize
  for iy = 1:ySize
    AScan = getAScan(zData,ix,iy);
    [~,idxPeaksPos] = findpeaks(diff(AScan),'MinPeakHeight',5,'MinPeakProminence',5);
    [~,idxPeaksNeg] = findpeaks(-diff(AScan),'MinPeakHeight',5,'MinPeakProminence',5);
    firstPeak = min([idxPeaksPos; idxPeaksNeg]);
    if isempty(firstPeak)
      firstPeak = NaN; % = 1
    end
    firstInterface(ix,iy) = firstPeak; % zData(firstPeak,ix,iy);
  end
  ix/xSize
end

% firstInterface(firstInterface==1)=NaN;

end

