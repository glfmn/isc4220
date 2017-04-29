%% Approximation: Lab 8
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Football Team rankings
clear

%%%
% Each 1 represents a win for each team; each -1 represents a loss for each
% team.  0 indicates a team didn't play.
%
% The final row adds sufficient conditions to find a solution.
game_matrix = [
    1 -1  0  0
    0 -1  1  0
    1  0  0 -1
    0  0  1 -1
    0  1  0 -1
    1  1  1  1
];
%%%
% Construct column vector of game score differences where the last element
% is the total.
differences = [
    4 9 6 3 7 20
]';

%%%
% Use linear least squares to determine the ranking numbers for the teams:
rank = (game_matrix'*game_matrix) \ (game_matrix'*differences);

fprintf('T1\tT2\tT3\tT4\n');
fprintf('%g\t%g\t%g\t%g\n',rank(1),rank(2),rank(3),rank(4));

%% 2014 Exam Problem
%
clear

% Data from problem specification
data = [
    0.00     2.10
    0.25     3.70
    0.50     6.26
    0.75    10.03
    1.00    16.31
];

xs = data(:,1);
ys = data(:,2);

%%%
% Using linear least squares, we can take the model
m1 = @(a,b,t) a.*t + b.*exp(2*t);
%%%
% and fit the parameters $$ a_1 $$ and $$ b_1 $$ to our data set to minimize
% the difference between the model and data where a and b are the linearly
% independent parameters to minimize using lls.

% Create a matrix seperating the linear terms of the model
A = [m1(1,0,xs) m1(0,1,xs)];

% Calculate coefficients with linear least squares
c = (A'*A)  \ (A'*ys);

ts = linspace(0,1,50);

% Plot results to inspect fitting
figure(1);
plot(xs,ys,'ro',ts,m1(c(1),c(2),ts),'b');
title('Model 1: Linear Least Squares');
legend('Data','Fitted Model');

%%
% Using non linear least squares we can take the model:
%
% $$m(t,\mathbf{a}) = a_0t + 2e^{a_1t}$$
m2 = @(a,b,t) a.*t + 2*exp(b.*t);
%%%
% And minimize the squared error term using a multi-dimensional
% optimization method such as bfgs.  The model is parameterized in terms of
% t, a, and b, where a and b are the parameters we hope to adjust to
% minimize the squared error. Using the cost function and gradient:
%
% $$r = m(t,\mathbf{a})-y$$
%
% $$\epsilon^2 = \sum_{i=1}^{n} r_i^2$$
%
% $$
% \[ \nabla\epsilon^2=\left[ \begin{array}{ccc}
% \sum_{i=1}^{n}-2r_it_i \\ 
% \sum_{i=1}^{n}-4r_it_ie^{a_0t}
% \end{array} \right] \]
% $$
r = @(c,x,y) m2(c(1),c(2),x) - y;
residual = @(c) sum(r(c,xs,ys).^2);

% Define gradient of cost function for bfgs
drda = @(c,x,y) -2.*r(c,x,y) .* x;
drdb = @(c,x,y) -4.*r(c,x,y) .* x .* exp(c(2).*x);
gradient = @(c) [
    sum(drda(c,xs,ys));
    sum(drdb(c,xs,ys))
];

% Report first two iterations
min = bfgs(residual, gradient, [-1; 1],1); % First iteration
fprintf('\nIteration 1: a:%g b:%g\n',min(1),min(2));
min = bfgs(residual, gradient, [-1; 1],2); % Second iteration
fprintf('\nIteration 2: a:%g b:%g\n',min(1),min(2));

% Perform non-linear least-squares and report solution
min = bfgs(residual, gradient, [-1; 1]);
fprintf('\nSolution: a:%g b:%g\n',min(1),min(2));

% Report minimum gradient value
minGrad = gradient(min);
fprintf('\nMinimum Gradient: [ %g %g ]\n', minGrad(1),minGrad(2));

% Plot results to inspect fitting
figure(2);
plot(xs,ys,'ro',ts,m2(min(1),min(2),ts),'b');
title('Model 2: Non-Linear Least Squares')
legend('Data','Converged Solution');