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

% successive refinement on approximations
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
