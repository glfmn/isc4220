function [ y, B ] = dd( xs, fs, x, B )
%DD is the divided difference interpolation of a set of points x and f(x)
%
%   DD(X, F, x) interpolates the function f from the points (x0,f0) where
%   X: is a vector
%   F: is a vector of length(X)
%   x: is a vector of points to interpolate
%   DD(X, F, x, B) interpolates f from the points (x0,f0) where
%   B: is a divided difference matrix
%   X: is a vector of new coordinates to calculate divided differences for
%   F: corresponds to X and has length(X)
%   This variant allows additional data points to improve the interpolation
%   of the function with a lower complexity, in this case O(n) instead of
%   O(n^2).

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

if nargin < 3, n = numel(f)-1; s=1; else s=size(B,1); n=s+numel(f)-1; end
if s==n,       warning('Will not update B matrix');                   end

for r=s:n
    B(r,1) = (f(r+1) - f(r)) / (x(r+1) - x(r));
    if r ~= 1
        for c = 2:size(B,1)
            r_ = r-c+1;
            B(r_,c) = (B(r_,c-1)-B(r_+1,c-1)) / (x(r_)-x(r+1));
        end
    end
end

end
