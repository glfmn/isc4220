function [ max, l, its ] = golden( f, a, b, maxIt, conv )
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
%   GOLDEN(f,xl,xu,maxIt,tol) will use the number tol as the tolerance in
%   the convergence criteria.
%   GOLDEN(f,xl,xu,maxIt,converge) will finish iterations when the converge
%   function evaluates to true.
%   [ fmax, its ] GOLDEN(...) returns the number of iterations along with
%   the maximum of the function.
%   [ fmax, xl, its] = GOLDEN(...) returns the range [x1,x2] after
%   performing iterations.
%
%   The default convergence criteria are:
%
%       tol = 10e-8;
%       @(xl,xu) abs(xu-xl) < tol;
%
%   Expects the convergence function to accept two numbers and return true
%   if the funciton has converged.

%%% Assign default arguments and handle input

dconv = @(l,u,tol) abs(u-l) < tol; % default convergence

if exist('f','var') == 0,      error('need a function to optimize');   end
if exist('a','var') == 0,      error('need a lower bound');            end
if exist('b','var') == 0,      error('need an upper bound');           end
if isnan(a) || isnan(b),       error('nan in interval bounds');        end
if isinf(a) || isinf(b),       error('inf in interval bounds');        end
if a > b,                      error('expect lower bound first');      end
if exist('maxIt','var') == 0,  maxIt = 50;                             end
if isnumeric('converge'),      tol = conv; conv=@(l,u) dconv(l,u,tol); else
                               tol = 10e-8;                            end
if exist('converge','var')==0, conv = @(l,u) dconv(l,u,tol);           end

%%% Define useful values

R = double((sqrt(5)-1)/2); % golden ratio

l = a + (1-R)*(b-a);
u = a + R*(b-a);

its = 0;

%%% Perform golden section section

converged = false;
for its = 1:maxIt
    if (f(l) < f(u))
        % Search the lower section
        b = u; u = l; % Update golden section upper bound
        l = a + (1-R)*(b-a); % New section lower bound
    else
        % Search the upper section
        a = l; l = u; % Update golden section lower bound
        u = a + R*(b-a); % New section lower bound
    end
    if conv(l,u), converged = true; break; end
end

if ~converged, warning('Function terminated without converging.'); end

if f(l) > f(u), max = f(l); else max = f(u); end

end

