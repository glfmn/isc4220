%% Newton's Method: Non-Linear Equations 2
% Uses Newton's Method to experiement with open methods for root finding.
% Implements specific example problems to better understand the properties
% of Newton's method when put into practice.
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Nth roots of real numbers
% The roots of real numbers are easy to approximate with the formula:
%
% $$ f{x} = x^{n} - a $$
%
% Using newtons method, we find the roots of this formula to find the
% square root of two and the fifth root of five to at least a precision of
% 10^-4.

clear

f  = @(x) x^2 - 2;
df = @(x) 2*x;

root = newton(f, df, 1, 10^-4); % approximate value of 2^(1/2)
true_err = abs(2^(1/2)-root);
fprintf('\napproximation of 2^(1/2) =\n\n    %g\n\n\n',root);
fprintf('true error =\n\n    %g\n\n\n',true_err);

f  = @(x) x^5 - 5;
df = @(x) 5*x.^4;

root = newton(f, df, 1, 10^-4); % approximate value of 5^(1/5)
true_err = abs(5^(1/5)-root);
fprintf('approximation of 5^(1/5) =\n\n    %g\n\n\n',root);
fprintf('true error =\n\n    %g\n\n\n',true_err);

%% Calculating $$ \pi $$
% Using John Machin's identity, we can solve for $$\pi$$.
%
% $$ 16\tan^{-1}{\frac{1}{5}} - 4\tan^{-1}{\frac{1}{239}} $$

n = 1:2:7;

%% Roots of $$ f{x} = \ln{x} $$ and $$ g{x} = 25^3 - 6x^2 + 7x - 88 $$

f = @(x) ln(x);
g = @(x) 25.*x.^2 - 6.*x.^2 + 7.*x - 88;

%% Newton's Method vs Bisection: $$ f{x} = 1 + \sin{x} $$
% Bisection fails for problems that do not cross the origin or the
% horizontal line at the desired value.  Newton's method will converge
% linearly; its convergence rate has decreased from quadratic to linear
% because the intercept has zero slope.

clear

f  = @(x) 1 + sin(x);
df = @(x) cos(x);


[root, its] = newton(f, df, 0)
f(root)
