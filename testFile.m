clc
clear all

%% load Z-scan

zData = loadZScan('scans/GaN module.saz');

% get image size
xSize = size(zData,2);
ySize = size(zData,3);

% detect useful data range
maxZval = max(abs([min(zData(:)) max(zData(:))]));

%% detect first interface

firstInterface = zeros(xSize,ySize);

parfor ix = 1:xSize
  for iy = 1:ySize
    AScan = getAScan(zData,ix,iy);
    [~,idxPeaksPos] = findpeaks(diff(AScan),'MinPeakHeight',5,'MinPeakProminence',5);
    [~,idxPeaksNeg] = findpeaks(-diff(AScan),'MinPeakHeight',5,'MinPeakProminence',5);
    firstPeak = min([idxPeaksPos; idxPeaksNeg]);
    if isempty(firstPeak)
      firstPeak = 1;
    end
    firstInterface(ix,iy) = firstPeak; % zData(firstPeak,ix,iy);
  end
  ix/xSize
end
firstInterface(firstInterface==1)=NaN;

%% 

x = round(xSize/2);
y = round(ySize/2);

AScan = getAScan(zData,x,y);
[~,idxPeaksPos] = findpeaks(diff(AScan),'MinPeakHeight',5,'MinPeakProminence',5);
[~,idxPeaksNeg] = findpeaks(-diff(AScan),'MinPeakHeight',5,'MinPeakProminence',5);
firstPeak = min([idxPeaksPos; idxPeaksNeg]);

figure(1); clf;
haAScan = subplot(5,1,1);
hoAScan = plot(haAScan, AScan);
haAScan.YLim = [-maxZval maxZval];
haAScan.XLim = [5000 7000];

haXScan = subplot(5,1,[2:5]);
hoXScan = imagesc(haXScan, firstInterface); % display 1st surface instead
haXScan.PlotBoxAspectRatio = [1 1 1];
colormap(haXScan,bone);
%hoAScanXY = line(haXScan,x,y,'Marker','o','Color','r');

%% surface trigger

xSurf = [];
ySurf = [];
button = 1;
while button == 1
  [x,y,button] = ginput(1); % check for bounds in x,y
  if (gca == haXScan && button==1)
    xSurf = [xSurf; round(x)]; %#ok<AGROW>
    ySurf = [ySurf; round(y)]; %#ok<AGROW>
    line(haXScan,x,y,'Marker','o','Color','r');
  end
end

zSurf = firstInterface(sub2ind(size(firstInterface), xSurf, ySurf));

%% 

% run cftool first and save fit to workspace
% exclude outliers!

fittedmodel(1:2,1:2)


%%

button = 1;
while button == 1
  switch gca
    case haAScan
      hoXScan.CData = double(squeeze(zData(floor(x),:,:)));
    case haXScan
      hoAScan.YData = getAScan(zData,round(x),round(y));
  end
  [x,y,button] = ginput(1); % check for bounds in x,y
  %   hoAScanXY.XData = x;
  %   hoAScanXY.YData = y;
end