function [ slice ] = sliceAtDepth( A, B )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

slice = A(sub2ind(size(A), B, repmat(1:size(A,2),size(A,3),1)', repmat([1:size(A,3)]',1,size(A,2))')); %#ok<NBRAK>

end

