%% Optimization: Lab 6
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Growth Rate
% The growth rate, g , of yeast used to produce an antibiotic depends on the
% concentration of the food c as:
%
%   g(c) = 2c / (4 + 0.8c + c^2 + 0.2c^3)
%
% The units of g and c, in the above equation, are per day and mg/L,
% respectively. The growth rate is small when c is small (as the yeast
% starve), and when c is very large (toxicity effects). We want to find the
% c at which g is maximum.
clear

%%%
% Implement the growth rate function as defined in the problem:
g = @(c) 2.*c ./ (4 + 0.8.*c + c.^2 + 0.2.*c.^3);
gp = @(c) 2*(-0.4 * c.^3 - c.^2 + 4) ./ (4 + 0.8.*c + c.^2 + 0.2.*c.^3).^2;

%%%
% Set x values for the plot
x    = 0:0.1:3;
xMax = golden(g,1,2);
xBis = bisection(gp,1,2);

%%%
% Plot the function and the maximum to visually inspect the results, and
% reveal the similarities between golden section search for maxima and the
% bisection method for root finding.
figure(1);
hold on;
title('Maximum growth rate');
%%%
% Plot g(x) vs its maximum to inspect result
plot(x,g(x));
plot(xMax,g(xMax),'r*');
%%%
% Plot g'(x) against its root
plot(x,gp(x));
plot(xBis,gp(xBis),'ro');
hold off;

%% RosenBrock
% The Rosenbrock function is often used to test the performance of
% optimization algorithms, because its global minimum, which occurs at
% (1,1), lies within a narrow parabolic valley.
%
%  f(x1,x2) = (1 − x1)^2 + 100(x2 − x1^2)^2
clear

%%%
% Implement the rosenbrock function as defined in the problem
r  = @(x1,x2) (1 - x1).^2 + 100*(x2 - x1.^2).^2;
r_ = @(x) r(x(1),x(2)); % r as a function that accepts a vector

%%%
% Implement gradient function
drdx1 = @(x) -2 + 2*x(1)-400*x(1).*(x(2) - x(1).^2);
drdx2 = @(x) 200*(x(2) - x(1).^2);
gr    = @(x) [ drdx1(x); drdx2(x) ];

%%%
% Calculate values of Z to enable plotting the function
range = 1.5;
step  = range/15;
[X,Y] = meshgrid(-range:step:range);
Z     = size(X);
Z     = r(X,Y);

%%%
% Calculate the minimum
[min, fmin, k] = bfgs(r_,gr,[-1;1],50);
x = min(1); y = min(2);
fprintf('Min %g at (%g,%g)\n',fmin,x,y);

%%%
% Plot the function and the minimum to visually inspect the results.
figure(2);
title('Minimum of the rosenbrock function');
view(-165,65);
hold on;
surf(X,Y,Z);
plot3(min(1),min(2),fmin,'ro');
hold off;

%%
% After 50 iterations bfgs() does not converge on a solution; it takes 122
% iterations for bfgs() to converge and find the global minimum of the
% rosenbrock function at (1,1)