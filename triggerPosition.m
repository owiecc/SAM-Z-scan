function [ idxThreshold ] = triggerPosition( A, threshold, fcn, range )
%triggerPosition   returns the indices of the values above threshold
%   in matrix A.

%% defaults
% Some function with 2 required inputs, 2 optional.

% Check number of inputs.
if nargin > 4
  error('myfuns:somefun2:TooManyInputs', ...
    'requires at most 2 optional inputs');
end

% Fill in unset optional values.
switch nargin
  case 2
    fcn = @(A,th) A > th;  % default A > threshold
    range = [1 size(A,1)]; % whole matrix
  case 3
    range = [1 size(A,1)]; % whole matrix
end

if isempty(fcn)
  fcn = @(A,th) A > th;  % default A > threshold
end

%% sanity check

%assert(diff([1 9])>0,'Range too small') % does not work for 1 deep arrays

%%

% find elements above threshold
triggeredA = fcn(A, threshold); %add range (range(1):1:range(2),:,:)

% return indexes of the first elements that are above threshold
[~, idxThreshold] = max(triggeredA);

% fix for empty columns (if threshold not crossed max returns 1)
idxThreshold(xor(triggeredA(1,:,:),idxThreshold==1)) = 0;
idxThreshold = squeeze(idxThreshold);

end

