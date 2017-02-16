function [ root ] = secantSolve( f,x0,x1, iter, tol)
%SECANTSOLVE: secant method for root finding.
%   Expects function f and numeric x0, where f is the function to find the
%   root for and x0 is the initial guess.
%
%   SECANTSOLVE(f,x,x0) returns a root of f with initial guesses: x0 x1.
%   SECANTSOLVE(_,_,_,k) will iterate k times, defaults to 25
%   SECANTSOLVE(_,_,_,_,tol) will stop iterations when |x-x0|/x < tol
%   SECANTSOLVE(_,_,_,_,converge) will stop when converge(x,x0) == true
%
%   Where x is the current iteration, and x0 is the previous.
%
%   SECANTSOLVE is an open method and as such may not converge.

% UTILITY FUNCTIONS

% Calculates the approximate relative error and absolute error respectively
relErr = @(x,x0) abs(x-x0)/x;
absErr = @(x,x0) abs(x-x0);

% Calculate the next iteration of the secant method.
secant = @(f,x0,x1) f(x0)*(x0 - x1) / (f(x0) - f(x1));

% ASSIGN DEFAULT VALUES
if nargin < 4                  , iter     = 25;                        end
if nargin < 5                  , tol      = 10^-6;                     end
if nargin < 5 || isnumeric(tol), converge = @(x1,x0)relErr(x1,x0)<tol; end

% PERFORM SECANT METHOD

for i=1:iter
   xtemp = x1;
   x1 = secant(f,x0,x1);
   x0 = xtemp;
   fprintf('iter: %g',i); 
   x1
   fprintf('Abs Err: %g\n\n',absErr(x0,x1));
   if converge(x0,x1), break; end
end

root = x1;
