%% Lab 11: Ordinary Differential Equtions
% *Gwen Zapata*, ISC4220: Algorithms for Science Applications
%%
%% Initial Value Problems: Spring Physics
% The motion of a mass $m$ attached to a spring of stiffness $k$, moving on
% a rough surface with friction coefficient $\mu$ may be described by the 
% differential equation:
%
% $$ m\frac{d^2 x}{dt^2} + \mu\frac{dx}{dt} + kx=0 $$
%
% with initial conditions $x(0)=1$ and $\frac{dx(0)}{dt}=0$
%
% This system represents a second-order, linear ordinary differential
% equiation because the terms are linearly independent.
%
% Setting $v = \frac{dx}{dt}$, we can rewrite the non-linear problem as a
% pair of linear initial value problems as:
%
% $$\frac{dv}{dt} = -\frac{1}{m} (\mu v + kx)$$
%
% $$\frac{dx}{dt} = v$$
%
% with updated initial conditions: $x(0) = 1$, $v(0) = 0$
%
% We can perform a Mid-Point solve with fixed step-size $h = 0.1$ for 
% the domain $0 \leq t \leq 4\pi$, setting the constsnats as $\mu = 0.0$,
% $\mu = 0.5$, $\mu = 2$, and $m = k = 1$.
clear

f  = @(t,y,mu) [y(2); -(mu.*y(2)+y(1))];
y0 = [1;0];
mu = [0, 0.5, 2];

eval = @(mu) ode2(@(t,y)f(t,y,mu),0,0.1,4*pi,y0);

[t, y] = arrayfun(eval,mu,'UniformOutput',false);

%%
% Plotting the results for the position of the mass on a spring with
% different $\mu$ we have:

desc = @(n) ['\mu = ' num2str(n)];

figure;

% Plot the position over time
subplot(2,1,1),...
    plot(t{1},y{1}(:,1),'r',t{2},y{2}(:,1),'b',t{3},y{3}(:,1),'y');
title('Solutions with different \mu');
legend(desc(mu(1)), desc(mu(2)), desc(mu(3)), 'Location','SouthEast');
xlabel('0 \leq t \leq 4\pi in seconds');
ylabel('position');   

% Plot the velocity over time
subplot(2,1,2),...
    plot(t{1},y{1}(:,2),'r',t{2},y{2}(:,2),'b',t{3},y{3}(:,2),'y');
legend(desc(mu(1)), desc(mu(2)), desc(mu(3)), 'Location','SouthEast');
xlabel('0 \leq t \leq 4\pi in seconds');
ylabel('velocity');

%%
% These plots reveal that the $\mu$ factor acts like a drag coefficient;
% that is, for higher $\mu$, the mass on the spring osscilates less and
% less quickly, and covers less distance; if the drag coefficient is zero,
% then the mass will osscilate forever.

%%% Examining midpoint method stability
% We can derive the region of stability for the midpoint method by the test
% function method, with the test function $y^\prime = \lambda y$, $y(0) =
% y_0$.
%
% $$
% y_n = y_{n-1} 
%   + h f\left(t_{n-1}+\frac{h}{2},
%              y_{n-1}+\frac{f(t_{n-1}}{2},y_{n-1}h)
%        \right)
% $$
%
% $$
% y_n = 1 + h\lambda \left(y_{n-1} + \frac{f(t_{n-1},y_{n-1}h)}{2}\right)
% $$
%
% $$
% y_n = y_{n-1}+h\lambda \left(y_{n-1}+\frac{h\lambda y_{n-1})}{2}\right)
% $$
%
% $$
% y_n = y_{n-1} + h\lambda y_{n-1} + \frac{h\lambda^2 y_{n-1}}{2}
% $$
%
% $$
% \frac{y_n}{y_{n-1}} = \left|1+h\lambda+\frac{h\lambda^2}{2}\right|\leq 1
% $$
eval = @(mu,h) ode2(@(t,y)f(t,y,mu),0,h,4*pi,y0);

clear t y;
[t{1}, y{1}] = eval(25,0.1);
[t{2}, y{2}] = eval(25,0.001);

test = @()0;
figure;
subplot(2,1,1), plot(t{1},y{1}(:,1));
title('Spring ODE \mu = 25');
ylabel('position');
subplot(2,1,2), plot(t{1},y{1}(:,2));
ylabel('velocity');
xlabel('0 \leq t \leq 4\pi in seconds');

%%
% This shows that for large $\mu$, the function leaves the region of
% stability without using an appropriately smaller step-size.  Reducing the
% step size produces a plot which now follows what we expect from the
% physical model, with $\mu$ again acting as a drag coefficient.

figure;
subplot(2,1,1), plot(t{2},y{2}(:,1));
title('Spring ODE \mu = 25, h = 0.001');
ylabel('position');
subplot(2,1,2), plot(t{2},y{2}(:,2));
ylabel('velocity');
xlabel('0 \leq t \leq 4\pi in seconds');

%% Boundary Value Problems
% The boundary value problem over the domain $0 \leq t \leq 1$:
%
% $$y^{\prime\prime} = y - t$$
%
% with boundary conditions: $y(t=0)=y(t=1)=0$ and the exact solution:
%
% $$y(t) = t + \left(\frac{e}{e^2-1}\right)(e^{-t}-e^t)$$
%
% Can be solved by the shooting method, but first we must transform the
% problem into a pair of first order ODEs.
%
% $$y^\prime = z$$
% $$z^\prime = y-t$$
%
% First we use $y^\prime(t=0) = 0$ and $y^\prime(t=0) = 1$ as the missing
% initial condition to calculate two final valules with matlab's intrinsic
% ode45 function.
clear
opts = odeset('RelTol',1.0e-4);

% Define provided values
exact = @(t) t + exp(1)./(exp(1).^2 - 1).*(exp(-t) - exp(t));
o = @(t,y) [y(2);y(1)-t];

if abs(exact(0)-exact(1)) > 1e-12,
    warning('Exact solution does not follow boundary conditions');
end

% Guess two starting values
guess = 10*rand(2,1);

[t{1}, y{1}] = ode45(o,[0 1],[guess(1); 0], opts);
[t{2}, y{2}] = ode45(o,[0 1],[guess(2); 0], opts);

%%% 
% Using the computed final values, we then perform a linear interpolation
% to calculate the exact solution.
%
% $$
% guess_1 + \frac{guess_2-guess_1}{final_2-final_1}(final_{true}-final_1)
% $$

solution = guess(1) + (guess(2)-guess(1))/(y{2}(end,2)-y{1}(end,2))...
    .*(0-y{1}(end,2));

[t{3}, y{3}] = ode45(o,[0 1],[solution; 0], opts);

fprintf('Where final 1 = %g, guess 1 = %g,',y{1}(end,2),guess(1));
fprintf('\nfinal_2 = %g, guess_2 = %g',y{2}(end,2),guess(2));
fprintf('\nwith a desired final value of 0 produces %g.\n\n',solution);

ts = 0:0.01:1;

figure;

hold on;
plot(ts,exact(ts),'r--');
plot(t{3},y{3}(:,2),'b-');
hold off;
title('Solutions to y'''' = y - t');
legend('exact',['y^\prime_i = ' num2str(solution)]);
xlabel('0 \leq t \leq 1');

%% Stiff Equations
%
% Integrating the following stiff differential equation with matlab's
% intrinsic ode45 and ode23s we can examine the difference in performance
% for methods of different order.
%
% $$ \frac{dr}{dt} = r^2 - r^3 $$
%
% The function represents the radius of a flame where $r^2$ is proportional
% to the surface area of the flame and $r^3$ is proportional to the volume of
% the flame.
%
% Comparing matlab's built-in ode45 and ode23s, we can examine the number
% of iterations and time taken to complete each method by using the timeit
% function and getting the length of the t vectors.
clear

% Define values as described in problem
drdt = @(r,t) r.^2 - r.^3;
phi = [0.1 0.0001 0.00001];

% Utility function to set span based upon phi
tspan = @(phi) [0 2./phi];

% Set realtive tolerance criteria for ode solvers
opts = odeset('RelTol',1.0e-4);

% Determine the numer of iterations for each method with different phi
solver = @(ode,phi) ode(drdt, tspan(phi), phi, opts);

[t1, r] = solver(@ode45,  phi(1));
[t2, r] = solver(@ode45,  phi(2));
[t3, r] = solver(@ode45,  phi(3));

[t4, r] = solver(@ode23s, phi(1));
[t5, r] = solver(@ode23s, phi(2));
[t6, r] = solver(@ode23s, phi(3));
clear r;

its = [ numel(t1), numel(t2), numel(t3);
        numel(t4), numel(t5), numel(t6)
];

% Determine the time taken for each method with different phi
timer = @(ode,phi) timeit(@() ode(drdt, tspan(phi), phi, opts));

time(1,:) = arrayfun(@(phi)timer(@ode45,phi),phi);
time(2,:) = arrayfun(@(phi)timer(@ode23s,phi),phi);

% Plot results to inspect what happens as phi increases for each method

figure;
subplot(2,1,1), semilogx(1./phi,its);
title('Numer of iterations for given \phi');
xlabel('1/\phi');
ylabel('n');
legend('ode45', 'ode23s','Location','northwest');

subplot(2,1,2), semilogx(1./phi,time);
title('Time for given \phi');
xlabel('1/\phi');
ylabel('s');
legend('ode45', 'ode23s','Location','northwest');

%%%
% The results show that ode45 takes a consistent amount of time while
% ode23s takes greater ammounds of time as phi decreses.  In fact, ode45
% has constant time complexity with respect to $\frac{1}{\phi}$, while 
% ode23s has logarithmic time complexity with respect to $\frac{1}{\phi}$.