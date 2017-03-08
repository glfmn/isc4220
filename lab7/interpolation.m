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