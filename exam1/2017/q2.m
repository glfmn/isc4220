%% Question 2: secant method.

% The function according to the problem: the volume of a hollow horizontal
% cylinder.
volume = @(r,h,l) l * ( r^2*acos((r-h)/h) - (r-h)*(sqrt(2*r*h-h^2)) );

% Apply the known values to the problem to obtain a function of height,
% and subtract the known volume to ensure that the root exists at y=0
f = @(h) volume(2,h,5) - 8.5;


fprintf('First three iterations (iii)');
secantSolve(f,2.0,2.5,3)

fprintf('First three iterations (iv)');
secantSolve(f,3.5,3.75,3)
