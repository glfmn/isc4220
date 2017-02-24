function [ max, its, a, b ] = golden( func, a, b, maxIt, converge )
%GOLDEN performs the golden section search to find maxima of a 2D function
%   over a range.  As a closed method it is guaranteed to converge as long
%   as only one maximum exists in the range.
%
%   To find the minima of a function, simply multiply the function by -1.
%
%   max = GOLDEN(f,xl,xu) performs the golden section search on function f
%   between in the range [xl,xu] returning the maximum inside the range.
%   GOLDEN(f,xl,xu,maxIt) performs the golden section search with a maximum
%   of maxIt iterations; defaults to 50, and expects an integer.
%   GOLDEN(f,xl,xu,maxIt,converge) will finish iterations when the converge
%   function evaluates to true.
%   [ max, its ] GOLDEN(...) returns the number of iterations along with
%   the maximum of the function.
%   [ max, its, xl, xu] = GOLDEN(...) returns the range [x1,x2] after
%   performing iterations.
%
%   The default convergence criteria are:
%
%       @(xl,xu) abs(xu-xl) < 10^-6
%
%   Expects the convergence function to accept two numbers and return true
%   if the funciton has converged.

%%% Assign default arguments

if nargin<4, maxIt    = 50;                        end
if nargin<5, converge = @(xl,xu) abs(xu-xl)<10^-8; end

%%% Define useful values

R = (sqrt(5)-1)/2; % golden ratio
d = R * (b-a);   % size of the golden section

its       = 0;
converged = false;
x1 = a + d;
x2 = b + d;
f1 = func(x1);
f2 = func(x2);

%%% Perform golden section

for its=1:maxIt
    d = R * d;
    if (f1 < f2)
        a = x2;
        x2 = x1;
        x1 = a + d;
        f2 = f1;
        f1 = func(x1);
    else
        b = x1;
        x1 = x2;
        x2 = b - d;
        f1 = f2;
        f2 = func(x2);
    end
    if converge(b,a), converged = true; break; end;
end

if ~converged, warning('Function terminated without converging.'); end

max = a;

end

