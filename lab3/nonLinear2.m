%% Newton's Method: Non-Linear Equations 2
% Uses Newton's Method to experiement with open methods for root finding.
% Implements specific example problems to better understand the properties
% of Newton's method when put into practice.
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Nth roots of real numbers
% The roots of real numbers are easy to approximate with the formula:
%
% $$f(x) = x^n - a$$
%
% Using newtons method, we find the roots of this formula to find
% $\sqrt{2}$ and $\sqrt{5}^5$ to at least a precision of $10^{-4}$.
%
% $$
% \begin{array}{rcl}
%       f(x) &=& x^2 - 2 \\
%       f^\prime(x) &=& 2x \\ \\
%       g(x) &=& x^5 - 5 \\
%       g^\prime(x) &=& 5x^4 \\
% \end{array}
% $$

clear

f  = @(x) x^2 - 2;
df = @(x) 2*x;

root = newton(f, df, 1, 10^-4); % approximate value of 2^(1/2)
true_err = abs(2^(1/2)-root);
fprintf('\n2^(1/2) = %g',root);
fprintf(', fzero of f(x) = %g',fzero(f,1));
fprintf(', true err = %g\n',true_err);

f  = @(x) x^5 - 5;
df = @(x) 5*x.^4;

root = newton(f, df, 1, 10^-4); % approximate value of 5^(1/5)
true_err = abs(5^(1/5)-root);
fprintf('\n5^(1/5) = %g',root);
fprintf(', fzero of g(x) = %g',fzero(f,1));
fprintf(', true err = %g\n',true_err);

%% Approximating $\pi$ with Machin's identity
% Using John Machin's identity, we can solve for $\pi$ by adapting the
% identity into an approximate value for pi.
%
% $$\pi=16\tan^{-1}{\frac{1}{5}} - 4\tan^{-1}{\frac{1}{239}}$$
%
% We can write taylor polynomials $p_n(x)$ of order $n=1,3,5,7$ and $9$ for
% the $tan^{-1}(x)$.
%
% $$
% \pi=16p_n\left({\frac{1}{5}}\right) - 4p_n\left({\frac{1}{239}}\right)
% $$
% $$
% \begin{array}{l}
%     p_1(x) = x\\
%     p_3(x) = x-\frac{x^3}{3}\\
%     p_4(x) = x-\frac{x^3}{3}+\frac{x^5}{5}\\
%     p_7(x) = x-\frac{x^3}{3}+\frac{x^5}{5}-\frac{x^7}{7}\\
%     p_9(x) = x-\frac{x^3}{3}+\frac{x^5}{5}-\frac{x^7}{7}+\frac{x^9}{9}
% \end{array}
% $$
clear

p = { @(x) x
      @(x) x-x.^3./3
      @(x) x-x.^3./3+x.^5./5
      @(x) x-x.^3./3+x.^5./5-x.^7./7
      @(x) x-x.^3./3+x.^5./5-x.^7./7+x.^9./9
    };

f = @(a,b,i)16*p{i}(a) - 4*p{i}(b);

fz = arrayfun(@(i)f(1/5,1/239,i),1:5);

figure(1);
plot(1:2:9,fz,1:2:9,fz,'o');
title('Approximate values of \pi');
ylabel('\pi');
xlabel('Order')


%% Roots of $f(x)=ln(x)$ and $g(x)=25^3-6x^2+7x-88$
%
% We can perform the zero through third order taylor expansions of each 
% function around $x=0$ and calculate their derivatives.
%
% For $f(x) = ln(x)$ we have:
%
% $$
% \begin{array}{rcl}
%     f_0(x) &=& x-1 \\
%     f_1(x) &=& (x-1) - \frac{(x-1)^2}{2} \\
%     f_2(x) &=& (x-1) - \frac{(x-1)^2}{2} + \frac{(x-1)^3}{3} \\
%     f_3(x) &=& (x-1) - \frac{(x-1)^2}{2} + \frac{(x-1)^3}{3} + 
%                \frac{(x-1)^4}{4} \\ \\
%     f^\prime_0(x) &=& 1 \\
%     f^\prime_1(x) &=& 2 - x \\
%     f^\prime_2(x) &=& x^2 - 3x + 3 \\
%     f^\prime_3(x) &=& 4x^2 -x^3 - 6x + 4
% \end{array}
% $$
%
% For $g(x) = 25x^3 - 6x^2 + 7x - 88$ we have:
%
% $$
% \begin{array}{rcl}
%     g_0(x) &=& -62\\
%     g_1(x) &=& -62 + 70(x-1)\\
%     g_2(x) &=& -62 + 70(x-1) + 69(x-1)^2\\
%     g_3(x) &=& -62 + 70(x-1) + 69(x-1)^2 + 25(x-1)^3\\ \\
%     g_0^\prime(x) &=& 0\\
%     g_1^\prime(x) &=& 70\\
%     g_2^\prime(x) &=& 138x - 68\\
%     g_3^\prime(x) &=& 75x^2 - 12x + 7
% \end{array}
% $$
%
% Plotting the zeros with the taylor expansions and the exact function we
% have:
clear

f   = @(x) log(x);

fp  = { @(x) (x-1)
        @(x) (x-1) - (x-1).^2 ./2
        @(x) (x-1) - (x-1).^2 ./2 + (x-1).^3 ./3
        @(x) (x-1) - (x-1).^2 ./2 + (x-1).^3 ./3 - (x-1).^4./4
      };
dfp = { @(x) 1
        @(x) 2 - x
        @(x) x.^2 - 3*x + 3
        @(x) 4*x.^2 - x.^3 - 6*x + 4
      };

g   = @(x) 25*x.^3 - 6*x.^2 + 7*x - 88;

gp  = { @(x) -62
        @(x) -62 + 70*(x-1)
        @(x) -62 + 70*(x-1) + 69*(x-1).^2
        @(x) -62 + 70*(x-1) + 69*(x-1).^2 + 25*(x-1).^3
      };
dgp = { @(x) 0
        @(x) 70
        @(x) 138*x - 68
        @(x) 75*x.^2 - 12*x + 7
      };

xs = (0:0.01:3.5)';

fz(1,:) = arrayfun(@(i)newton(fp{i},dfp{i},3, 10^-4),1:4);
fz(2,:) = arrayfun(@(i)fzero(fp{i},3),1:4);

fps  = arrayfun(@(i)fp{i}(xs), 1:4,'UniformOutput',false);
fps  = [ fps{1}'; fps{2}';  fps{3}';  fps{4}' ]';

figure(2);
subplot(2,1,1), hold on
plot(xs,f(xs),'r');
plot(fz(1,:),zeros(size(fz(1,:))),'x');
plot(fz(2,:),zeros(size(fz(2,:))),'o');
plot(xs,fps,'b--');
hold off;
title('ln(x)');

gz(1,:) = arrayfun(@(i)newton(gp{i},dgp{i},1.5, 10^-4),2:4);
gz(2,:) = arrayfun(@(i)fzero(gp{i},3),2:4);

gps  = arrayfun(@(i)  gp{i}(xs),2:4,'UniformOutput',false);
gps  = [  gps{1}'; gps{2}';  gps{3}' ]';

subplot(2,1,2), hold on
plot(xs,g(xs),'r');
plot(gz(1,:),zeros(size(gz(1,:))),'x');
plot(gz(2,:),zeros(size(gz(2,:))),'o');
plot(xs,gps,'b--');
hold off;
title('25x^3 - 6x^2 + 7x - 88');
legend('true','newton','fzero','taylor expansions','Location','NorthWest');

%%
% Examining the true relative error between the numerical solutions and the
% exact solutions:
%
% $$
% \begin{array}{ll}
%       f(x)=ln(x) & f(1.5409)=0\\
%       g(x)=25x^3 - 6x^2 + 7x - 88 & g(1)=0
% \end{array}
% $$

ft = 1.5409;
gt = 1;

figure(3);
subplot(2,1,1),
plot(1:3,(gz(1,:)-gt)./gz(1,:),'o',1:3,(gz(2,:)-gt)./gz(2,:),'*');
title('ln(x)');
subplot(2,1,2),
plot(1:4,abs(fz(1,:)-ft)./fz(1,:),'o',1:4,abs(fz(2,:)-ft)./fz(2,:),'*');
title('25x^3 - 6x^2 + 7x - 88');
legend('newton','fzero');


%% Newton's Method vs Bisection: $f(x) = 1 + sin(x)$
% Bisection fails for problems that do not cross the origin or the
% horizontal line at the desired value.  Newton's method will converge
% linearly; its convergence rate has decreased from quadratic to linear
% because the intercept has zero slope.

f  = @(x) 1+sin(x);
df = @(x) -cos(x);

figure(4);
xs = 0:1/(12*pi):8*pi;
plot(xs,f(xs),xs,df(xs));
title('1 + sin(x)');
legend('f(x)','f^''(x)');
