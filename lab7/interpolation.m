%% Interpolation: Lab 7
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Gamma Function
%
%
%
clear

%%%
% Define interpolation dataset according to the assignment
x  = 1:5;
f = [1 1 2 6 24];

%%%
% Define interpolation range and calculate interpolated values.
xs = 0.1:0.1:6;
ys = gamma(xs);
yi = interp1(x,f,xs,'spline');

%%%
% Plot interpolated values alongside original funciton to inspect the
% restults, comparing the actual gamma function to the interpolated
% functions.
figure(1);
hold on;

plot(xs,ys);     % intrinsic gamma
plot(xs,yi);     % interp1
plot(x,f,'ok'); % Data points

hold off;

legend('Gamma function','Splines','Sample points');
title('Gamma function and interpolations');

%% Successive Parabolic Optimization
%
%
%
clear

%%%
% Define datasets based on the three points described in the problem:
%
%  (1,3), (2,5), (3,3)
%
x = [1 2 3];
f = [3 5 3];
%%%
% Calculate the maximum according to the formula to test against.
xmax = (f(1)*(x(1)^2-x(2)^2)+f(2)*(x(3)^2-x(1)^2)+f(3)*(x(2)^2-x(1)^2))...
     / 2* (f(1)*(x(2)-x(3)) +  f(2)*(x(3)-x(1)) + f(3)*(x(1)-x(2)) );

%%%
% Plot the datasets to visually inspect the result, comparing the original
% dataset's points to the value of xmax and the maximum of the
% interpolated polynomial.

figure(2);

hold on;
plot(x,f,'ok');
hold off;

title('Successive Parabolic Optimization');
legend('sample points');
