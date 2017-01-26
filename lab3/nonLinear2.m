%% Newton's Method: Non-Linear Equations 2
% Uses Newton's Method to experiement with open methods for root finding.
% Implements specific example problems to better understand the properties
% of Newton's method when put into practice.
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Calculating $$ \pi $$
% Using John Machin's identity, we can solve for $$\pi$$.
%
% $$ 16\tan^{-1}{\frac{1}{5}} - 4\tan^{-1}{\frac{1}{239}} $$

n = 1:2:7;

%% Roots of $$ f{x} = \ln{x} $$ and $$ g{x} = 25^3 - 6x^2 + 7x - 88 $$

f = @(x) ln(x);
g = @(x) 25.*x.^2 - 6.*x.^2 + 7.*x - 88;

%% Newton's Method vs Bisection: $$ f{x} = 1 + \sin{x} $$

f = @(x) 1 + sin(x);
