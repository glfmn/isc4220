function [ A ] = pivot( A )
%PIVOT performs partial pivoting on a matrix after scaling by row sums
%   First scales each row by the row sum, then orders the rows by the
%   maximum element in each scaled row.

scale = @(A) A * diag(1./sum(A,2));

% Perform row scaling
A = scale(A);

rows = size(A,2);

for row = 1:rows-1
    [Y,I] = max(A)
    
end
