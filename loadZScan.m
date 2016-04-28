function [ zData ] = loadZScan( fInput )
%loadZScan Loads Z-scan data
%   ZDATA = loadZScan() Opens a file dialog and returns Z-scan data. Dimension 1
%   contains sampled sensor signal. Due to memory limitations ZDATA is returned
%   in INT8 format.
%
%   ZDATA = loadZScan(FILENAME) Returns rata from a specified file.

%% get and open the file reference

if nargin==0
  [fName,fPath,~] = uigetfile({'*.saz', 'KSI V8 Z-scan files (*.saz)'; '*.*', 'All Files (*.*)'});
else
  [fPath,fName,fExt] = fileparts(fInput);
  fName = [fName fExt];
end

fFullPath = fullfile(fPath,fName);
fid = fopen(fFullPath,'r');

%% get scan parameters from header

headerSize = 496; % fixed size
packetSize = 15008; % may be variable due to varying depth of scan /// TODO

fseek(fid,480,'bof');
imgWidth = fread(fid,1,'int16=>double');

fseek(fid,484,'bof');
imgHeight = fread(fid,1,'int16=>double');

%% load and reshape the scan data

fseek(fid,headerSize,'bof');
fData = fread(fid,packetSize*imgWidth*imgHeight,'int8=>int8');
zData = reshape(fData,[packetSize,imgWidth,imgHeight]);

fclose(fid);

end

