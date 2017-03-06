function zData = loadZScan(fInput)
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

% find file size
fseek(fid, 0, 'eof');
fSize = ftell(fid);

% fixed header size
headerSize = 496;
idxXdim = 480;
idxYdim = 484;

% calculate Z-scan size
scanSize(1:2) = getDimensions(fid,[idxXdim,idxYdim]);
scanSize(3) = (fSize - headerSize)/prod(scanSize(1:2));

%% load and reshape the scan data

fseek(fid,headerSize,'bof');
fData = fread(fid,prod(scanSize),'int8=>int8');
zData = reshape(fData,[scanSize(3),scanSize(1),scanSize(2)]);

% close file reference
fclose(fid);

% helper functions
  function [xy] = getDimensions(fid,idxsDim)
    xy = [];
    for idxDim = idxsDim
      fseek(fid,idxDim,'bof');
      xy = [xy,fread(fid,1,'int16=>double')];  %#ok<AGROW>
    end
  end
end

