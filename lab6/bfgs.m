function [ x, fx, its ] = bfgs( f, gf, x, k, converge )
%BFGS finds a minimum of a multi-dimensional function with the BFGS method.
%   To calculate the maximum, simply pass in -gradient, and leave f as is.
%
%   BFGS(f, gf, x) calculates the minimum of f--where gradient is f's
%   gradient function--from initial guess x where:
%   x is a column vector
%   f is a function that accepts a vector size(x) and returns a scalar
%   gf is the gradient of f and accepts a vector size(x) and returns a
%   vector size(x)
%   BFGS(f,gf,x,k) will exit after performing k iterations, defaults to 50.
%   BFGS(f,gf,x,k,converge) will finish iterations when convege(x)
%   evaluates to true; by default, 
%
%       converge = @(x) norm(gf(x)) < 10^-3
%   
%   BFGS is an open method and has a chance to diverge; the function will
%   warn when iterations have finished without converge(x) evaluating to
%   true.
%
%   [ x, fx, k ] = BFGS(...) where
%   x is the vector that produces the minimum
%   fx = f(x)
%   k is the number of iterations

% Set default arguments
if nargin < 4, k        = 50;                       end
if nargin < 5, converge = @(x) norm(gf(x)) < 10^-3; end

% Set initial approximation for hessian to negative gradient
B = eye(length(x));

% Implement alrogrithm
yk     = @(xk,x)  gf(xk) - gf(x);
sk     = @(x,B)   B\(-gf(x));
update = @(y,s,B) B + (y*y')/(y'*s) - (B*s*s'*B)/(s'*B*s);

% Perform iterations
its       = 0;
converged = false;

for its=1:k
    s  = sk(x,B);
    xk = x + s;
    B  = update(yk(xk,x),s,B);
    x  = xk;
    if converge(x), converged = true; break; end
end

if ~converged, warning('Finished %g iterations without converging',k); end

% Set return values
fx = f(x);

end

