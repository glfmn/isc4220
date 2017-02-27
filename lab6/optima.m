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
clear

% Implement the rosenbrock function as defined in the problem
r = @(x_1, x_2) (1 - x_1).^2 + 100*(x_2 - x_1.^2).^2;

% Calculate values of Z to enable plotting the function
range = 2;
step  = 0.1;
[X,Y] = meshgrid(-range:step:range);
Z     = size(X);
Z     = r(X,Y);

figure(2);
surf(X,Y,Z);