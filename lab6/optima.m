%% LU Decomposition and Gauss-Seidel
% 
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Growth Rate
clear

% Implement the growth rate function as defined in the problem
g = @(c) 2.*c ./ (4 + 0.8.*c + c.^2 + 0.2.*c.^3);

% Set x values for the plot
x     = 0:0.1:3;
x_max = golden(g,1,2)

% Plot the function and the maximum to visually inspect the result
figure(1);
plot(x,g(x),x_max,g(x_max),'r*')

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