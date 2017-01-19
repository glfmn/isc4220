function [ xst, erra, iter ] = bisection( func, a, b, tol )
%  BISECTION finds roots using the bisection method
%    Requires a function name to evaluate, and some interval [a,b] where
%    a and b change signs.  Will bisect the interval until a root is found
%    with sufficient tolerance to escape the loop.

if nargin < 4, tol = 10^-4; end

newX = @(a,b) (a+b)/2;
iter = 0;

while abs(a-b) > abs(tol) % Iterate until interval is sufficiently small
    % determine approximate error to help check convergence
    if iter > 0, erra = abs( (newX(a,b)-xst) / xst ); end

    iter = iter + 1;

    xst = newX(a,b); % Claculate midpoint of the interval
    choice = func(a)*func(xst); % Determine sign difference at a and xst

    if (choice <  0), b = xst; end % Root is in [a, xst]
    if (choice == 0), break;   end % Exit, root was found
    if (choice >  0), a = xst; end % Root is in [xst, b]
end


end
