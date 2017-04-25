%% Numerical Integration: Lab 10
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%

%% $$ sqrt(t) log(t) $$
clear

i = @(t) sqrt(t) .* log(t);
exact = -4/9;

%%%
% Calculate the trapezoidal rule integrals with ns of 1, 2, 4, and 8.
xs = [0,1]; ys = i(xs); ys(1) = 0;
approx(1) = trapz(xs,ys); % n of 1

xs = linspace(0,1,3); ys = i(xs); ys(1) = 0;
approx(2) = trapz(xs,ys); % n of 2

xs = linspace(0,1,5); ys = i(xs); ys(1) = 0;
approx(3) = trapz(xs,ys); % n of 4

xs = linspace(0,1,9); ys = i(xs); ys(1) = 0;
approx(4) = trapz(xs,ys); % n of 8

%%%
% Calculate the error using the known exact integral, and plot the error
% to evaluate the trapezoidal rule's convergence properties.

ns = [1,2,4,8];
aerr = abs(approx -  exact);
rerr = aerr ./ abs(approx);

figure(1);
hold on;
plot(ns, rerr, ns,aerr);

%%%
% Calculate the integral with romberg successive refinement to get the most
% refined answer given the values already calculated, and compare with full
% romberg function.

% refinement on approximations
for m = numel(approx):-1:2
    d = 4^(m-1);
    approx(m) = (d*approx(m) - approx(m-1)) / (d-1);
end

fprintf('The refined estimate is %g ',approx(4));
fprintf('with error value of: %g\n', abs(approx(4)-exact));
plot(ns,abs(approx-exact));

% Because the integral is undefined at 0, the answer will have extra error 
% as the routine must start near 0 instead of at 0.
n = 10539; % The number of iterations required to converge
[I, Is, c, n] = romberg(i,0.0000000000000001,1,1e-10,n);

if c, fprintf('Romberg converged on %g with %g iterations\n',I,n); end

title('Integration error with trapezoidal rule for sqrt(t)log(t)');
xlabel('n');
ylabel('error');
legend('relative error','absolute error','romberg refined');
hold off;

%% $$ erf $$ & $$ exp(-x^2) $$
clear

%%%
% Implement the function we hope to integrate, caclulate the exact
% integral, and estimate the integral with simpson's rule and Gauss
% Quadrature.

i = @(t) exp(-t.^2);
exact = sqrt(pi)/2 * erf(2);

I1 = simpson(i,0,2);
I2 = gaussQuad(i,0,2);

%%%
% Compare Simpson's 1/3 rule and Gauss Quadrature with 4 segments in each
% method.

figure(2);
hold on;

plot(4,abs(I1-exact),'b*',4,abs(I2-exact),'r*');
text(4.05,abs(I1-exact), ['absolute error = ' num2str(I1-exact)]);
text(4.05,abs(I2-exact), ['absolute error = ' num2str(I2-exact)]);
axis([3.5 5 -0.1, 0.3]);

title('Integration error, Simpson''s 1/3 rule vs Gauss Quadrature');
xlabel('n');
ylabel('error');
legend('simpson''s rule','Gauss Quadrature');
hold off;

%% Evaluating integrals with Gauss Quadrature
clear

i = @(t) 1 ./ (exp(t) + exp(-t)); % from -1 to 1, and from 0 to 2

I1 = gaussQuad(i,-1,1);
I2 = gaussQuad(i,0,2);

fprintf('Integral from -1 to 1: %g\nIntegral from  0 to 2: %g\n',I1,I2);

%% Infinite bounds in integrals
% To evaluate the integral $\int_{1}^{\inf} \frac_{\sin(x)}{x^2} dx$ we may
% choose a numerial integration method such as Gauss Laguerre or Gauss
% Hermite which can accomodate bounded integrals with infinite bounds.

%% Double Integarls
% To calculate the integral of
% $\int_{0}^{1}\int_{0}^{1} e^{−x_1^3 +x_2^3} dx_1 dx_2$ it is possible to
% perform standard numerical integration as the bounds of the double 
% integral are very simple.
%
% For $\iint_D e^{−x_1^3 +x_2^3} \,dx_1\,dx_2$, where 
% $D: x_1^2 + 2x_2^2 \let 1$ best suits monte carlo methods because of the
% complicated bounds of integration.  Monte carlo methods can handle
% arbitrary bounds.
