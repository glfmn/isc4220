%% Bisection Rule: Assignment 2
% Implements a bisection library function and then uses it to solve some
% example problems to get a better sense of the process required to find
% roots with the bisection method.
%
% *Gwen Zapata*
% *ISC4220C*
%%
%% Finding Roots of an Example Problem
% Find a solution to:
% $$ 0=\tan(x)-\frac{1}{1+x^2} $$
% using the bisection method.

f1 = @(x) tan(x) - 1./(1+x.^2);

f1_root = bisection(f1,0,1,10^-4)

% Plot the function to visually inspect result
xs = 0:0.1:f1_root*2;
ys = f1(xs);
plot(xs,ys,'b',f1_root,f1(f1_root),'or')

%% Maximum Interest Rate
% Given a maximum monthly payment of $800, and a loan period of five years,
% what is the maximum interest rate for the loan?
%
% $$ P = L\frac{i_m(1+i_m)^n}{(1+1_m)^n-1} $$ 
% We can express this function as
% $$ P = P_max - L\frac{i_m(1+i_m)^n}{(1+1_m)^n-1} $$ 
% so that the value of the function is zero when the monthly payment is
% equal to the maximum monthly payment.

payment = @(L, n, Pmax, i_m) ...
    Pmax - L .* (i_m.*(1+i_m).^n) ./ ((1+i_m).^n - 1);

P_max = 500:100:1000;

months = 15 * 12; % period of the loan in months

min  = -0.002;
step =  0.0001;
max  =  0.01;

xs = min:step:max; % Define domain for interest function
ys = zeros(size(P_max,2),size(xs,2)); % Preallocate range to optimize

hold on;
for n=1:6,
    f2 = @(x) payment(100000,months, n*100 + 400, x);
    f2_root = bisection(f2,0,1,10^-4);
    plot(xs, f2(xs), f2_root, f2(f2_root),'r');
end
hold off;
