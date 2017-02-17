function [ x ] = triDiagSolve(A, r, debug)
% TRIDIAGSOLVE implements special algorithm to solve tridiagonal matricies
%   Expects a matrix A, and vector r where A is n x n and r is n x 1.

if nargin < 2, debug = false; end

if size(A,1) <  size(A,2), warning('\nSystem is under-constrained\n');  end
if size(A,1) >  size(A,2), warning('\nSystem is over-constrained\n');   end
if size(A,1) ~= size(r,1), warning('\nMatrix inner bounds mismatch\n'); end

% Preallocate result vectors
a = zeros(size(A,1));
y = zeros(size(r,1));
x = zeros(size(r,1));

% Define initial values
a(1) = 1/A(1);
y(1) = r(1);
x(1) = y(1)*a(1);
md   = 2;
as   = 0;

nextAlpha = @(A,a,i)     1 / (A(i,i) - A(i,i-1)*a(i-1)*A(i-1,i));
nextY     = @(A,a,y,r,i) r(i) - A(i,i-1)*a(i-1)*y(i-1);

for i=2:size(A,1)
    a(i) = nextAlpha(A,a,i);
    y(i) = nextY(A,a,y,r,i);
    x(i) = y(i)*a(i);
    
    if debug == true
        md = md + 5;
        as = as + 2;
    end
end


if debug == true
    fprintf('Operations:\n\tmult/div: %g\n\tadd/sub: %g', md, as);
end

