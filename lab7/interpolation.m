%% Interpolation: Lab 7
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Gamma Function
%
% Use the values of the gamma function from 1 to 5 to interpolate the
% function using the built in splines interpolation, and my implementation
% of divided difference interpolation to test the results.
%
clear

%%%
% Define interpolation dataset according to the assignment
x  = 1:5;
f = [1 1 2 6 24];

%%%
% Define interpolation range and calculate interpolated values.
xs = linspace(1,6,100);
ys = gamma(xs);
yi = interp1(x,f,xs,'spline');
yd = dd(x,f,xs);

%%%
% Plot interpolated values alongside original funciton to inspect the
% restults, comparing the actual gamma function to the interpolated
% functions.
figure(1);
hold on;
plot(xs,ys);     % intrinsic gamma
plot(xs,yi);     % interp1
plot(xs,yd);     % Divided difference interpolation
plot(x,f,'ok');  % Data points
hold off;

legend('Gamma function','Splines','Divided Difference','Sample points');
title('Gamma function and interpolations');

%% Successive Parabolic Optimization
%
% By finding the interpolated funciton between the three points of the
% polynomial, we can identify the maximum of a parabola and check against
% the successive optimization formula for determining the x-coordinates of
% the maximum.
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
numerator = ...
    ( f(1)*(x(2)^2-x(3)^2)...
    + f(2)*(x(3)^2-x(1)^2)...
    + f(3)*(x(1)^2-x(2)^2)...
    );
denomenator = ...
     ( f(1)*(x(2)-x(3))...
     + f(2)*(x(3)-x(1))...
     + f(3)*(x(1)-x(2))...
     );
xmax = numerator/(2*denomenator);

xs = linspace(0.5,3.5,50);
fs = dd(x,f,xs);


%%%
% Plot the datasets to visually inspect the result, comparing the original
% dataset's points to the value of xmax and the maximum of the
% interpolated polynomial.

figure(2);

hold on;
plot(x,f,'ok');
plot(xs,fs);
plot(xmax,5,'+r')
hold off;

title('Successive Parabolic Optimization');
legend('sample points','interpolated','max');
