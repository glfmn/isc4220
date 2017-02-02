function [ root, it ] = newton( f, df, x, tol, maxit )
%NEWTON finds roots of non-linear equations using their first derivative
%   As an open method for Root Finding, Newton's method may diverge.
%   However, it converges quadratically in the best case.  If the root has
%   a slope of zero at it's root, then convergence becomes linear.
%   Generally, Newtons Method diverges more often when the slope has a low
%   magnitude near the root.
%
%   NEWTON(f,df,x,tol,maxit) find root of f starting from x, with tolerance
%   tol and maximum number of iterations maxit, where df is the first-order
%   derivative of f.
%   NEWTON(f,df,x,tol) find root with maxit 25
%   NEWTON(f,df,x) find root with tolerance 10^-6 and maxit 25
%   NEWTON(f,df) find root starting at x=0 with tolerance 10^-6 and maxit
%   25
%
%   [root] = NEWTON(f,df,...) the root, assuming convergence has occured
%   [root, it] = NEWTON(...) the root and the number of iterations

% Set sensible default values
if nargin < 5, maxit = 25;    end
if nargin < 4, tol   = 10^-6; end
if nargin < 3, x     = 0;     end

% Define convergence criteria
converge = @(val) abs(tol) > abs(f(val)) >= 0;

% Implement Newton's Method in terms of f, x_i, and df/dx.
newt = @(x) x - f(x) - df(x);

it = 0;
for i=1:maxit
    if converge(x), break; end
    x = newt(x);
    it = i;
end

