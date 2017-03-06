function ax = gateIdxs(idxs,nelGate)
%GATEIDXS Creates indexes for a gate
%   gateIdxs(idxs,nelGate) Returns linear indexes for indexing 
%   a 3D array where idxs contains the front of the gate (linear indexes)
%   down to nelGate elements. 
as = repmat(idxs,nelGate,1);
b = (0:nelGate-1)';
bs = repmat(b,1,numel(idxs));
ax = as+bs;
ax = ax(:);
end

