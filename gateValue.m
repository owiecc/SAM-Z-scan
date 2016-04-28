function [ scanValue ] = gateValue( A, fcn, range )
%gateValue   Returns the scalar value of the data from matrix A in 
%   the defined range. The scalar value is calculated by a fcn function.
%   Pass fcn as an anonymous function, e.g. @(x) mean(x)

scanValue = squeeze(fcn(A(range(1):range(2),:,:))); 

end

