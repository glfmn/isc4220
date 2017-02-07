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
fprintf('\nfzero of f(x) =\n\n    %g\n\n\n',fzero(f,1));
fprintf('true error =\n\n    %g\n\n\n',true_err);

f  = @(x) x^5 - 5;
df = @(x) 5*x.^4;

root = newton(f, df, 1, 10^-4); % approximate value of 5^(1/5)
true_err = abs(5^(1/5)-root);
fprintf('approximation of 5^(1/5) =\n\n    %g\n\n\n',root);
fprintf('\nfzero of f(x) =\n\n    %g\n\n\n',fzero(f,1));
fprintf('true error =\n\n    %g\n\n\n',true_err);

%% Calculating $$ \pi $$
% Using John Machin's identity, we can solve for $$\pi$$.
%
% $$ 16\tan^{-1}{\frac{1}{5}} - 4\tan^{-1}{\frac{1}{239}} $$

clear

%% Roots of $$ f{x} = \ln{x} $$ and $$ g{x} = 25^3 - 6x^2 + 7x - 88 $$

clear

f   = @(x) log(x);

fp  = { @(x) 0
        @(x) (x-1)
        @(x) (x-1) - (x-1).^2 ./2
        @(x) (x-1) - (x-1).^2 ./2 + (x-1).^3 ./3
      };

dfp = { @(x) 0
        @(x) 1
        @(x) 2 - x
        @(x) x.^2 - 3*x - 3
      };

g   = @(x) 25*x.^3 - 6*x.^2 + 7*x - 88;

gp  = { @(x) x 
      };

dgp = { @(x) 0
      };

for i=1:4, 
    froot(i) = newton(fp{i},dfp{i},3, 10^-4, 25);
    % groot(i) = newton(gp{i},dfp{i},3, 10^-4);
end

fzero(fp{1},3)

froot

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
