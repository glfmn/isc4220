function [ y, B ] = dd( xs, fs, x, B )
%DD is the divided difference interpolation of a set of points x and f(x)
%
%   DD(X, F)

% Either calculate new matrix of divided differences, or update the
% matrix passed into the function
if nargin < 4, B = b(fs,xs); else B = b(fs,xs,B); end

% Validate arguments
if size(xs) ~= size(fs), error('size of xs and fs must match'); end

% Define the first terms of the interpolating polynomial
f = @(x) fs(1);
t = @(x) 1;

for n=1:numel(xs)-1
    t = @(x) t(x) .* (x - xs(n));   % define the next polynomial term
    f = @(x) f(x) + B(1,n).*t(x); % add next polynomial term to f
end

y = f(x);

end

function [B] = b(f, x, B)
%B calculates the B matrix of divided difference values, or updates the
%   given a square B matrix with the next set of divided difference values.
%
%       b[x0..xn] = b[0..n-1] - b[1..n] / x0 - xn
%       b[x0..x1] = f(x0)     - f(x1)   / x0 - x1

if nargin < 3, n = numel(f)-1; s=1; else n = numel(f)-1; s=size(B,1); end

for row=s:n
    B(row,1) = (f(row+1) - f(row)) / (x(row+1) - x(row));
    if row ~= 1;
        for col = 2:size(B,1)
            row_ = row-col+1;
            B(row_,col) = (B(row_,col-1)-B(row_+1,col-1)) / (x(1)-x(col));
        end
    end
end

end
