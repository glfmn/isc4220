%% Numerical Differentiation
% *Gwen Zapata*, *ISC4220*
%%
%% Approximating total error
%
% Examining the truncation error and and round-off error for the
% fourth-order central difference formula for estimating the second
% derivative:
%
% $$\frac{\partial^2 u}{\partial x^2} \approx
% \frac{-u(x-2h) + 16u(x - h) - 30u(x) + 16u(x + h) - u(x + 2h)}{12h^2}$$
%
% Because our function $u(x)$ is $e^x$, all of its derivatives are also
% $e^x$ making it easy to come up with an exact analytical expression for
% truncation error we get from the fourth order central difference formula:
%
% $$\epsilon_{truncation}(x,h)= \frac{h^4}{90} e^x$$

truncation = @(x,h) (h.^4)/90 .* exp(x);

%%%
% If we assume machine precision of $10^{-16}$ we can derive an expression
% for the roundoff error (ignoring prefactors):
%
% $$\epsilon_{roundoff} = \frac{10^{-16} u(x)}{12h^2}$$

roundoff = @(x,h) 10e-16*exp(x) ./ (12*h.^2);

total = @(x,h) truncation(x,h) + roundoff(x,h);

%%%
% And thus the complete expression becomes:
%
% $$\epsilon_{total} = \frac{h^4}{90}e^x + \frac{10^{-16} u(x)}{12h^2}$$

% fourth-order central difference formula defined earlier with u(x)=exp(x)
d = @(x,h)...
    (-exp(x-2*h) + 16*exp(x-h) - 30*exp(x) + 16*exp(x+h) - exp(x+2*h))...
    ./(12*h.^2);

absErr = @(x,h) abs(exp(x)-d(x,h));

%% Investigating error properties
% Since we have an easy analytial solution for second derivative, we can
% take the absolute error between the second derivative and the central
% difference formula, and just use a method like the golden section search
% to minimize that error.

[minErr,h] = golden(@(h)absErr(0,h),0,1,100,10e-16);

%%%
% Comparing h values of the derivative at $x = 0$ to the expression for the
% total error, and plotting the optimal h and the minimum error we have:

figure(1);
hs = logspace(-10,0,100); % logarithmically equispaced domain
loglog( hs,total(0,hs)...
      , hs,absErr(0,hs),'m:'...
      , h,minErr,'ro');
legend( 'error expression'...
      , 'absolute error'...
      , sprintf('optimal h of 10^{%g}',log10(h)));
text(h/2,minErr,sprintf('min err %g',minErr)...
    ,'HorizontalAlignment','right');
ylabel('error');
xlabel('h');
title('Order of total error at x=0');

%%

figure(2);
xs = 0:0.005:1;
semilogy( xs,absErr(xs,h),     'm-'...
        , xs,absErr(xs,h/10),  'r--'...
        , xs,absErr(xs,h/100), 'b--'...
        , xs,absErr(xs,h*10),  'c--'...
        , xs,absErr(xs,h/1000),'g--');
legend( sprintf('optimal h of 10^{%g}',log10(h))...
      , sprintf('h of 10^{%g}', log10(h/10))...
      , sprintf('h of 10^{%g}', log10(h/100))...
      , sprintf('h of 10^{%g}', log10(h*10))...
      , sprintf('h of 10^{%g}', log10(h/1000)));
ylabel('absolute error');
xlabel('x');
title('Absolute error for different h');

%%

figure(3);
hold on;
title('Analytical derivative and central difference approximations');
plot(xs,exp(xs),'c-', 'LineWidth', 2);
plot( xs,d(xs,h),       'r--'...
    , xs,d(xs,h/100000),'m:');
legend( 'true derivative'...
      , sprintf('optimal h of 10^{-%g}',log10(h))...
      , sprintf('h of 10^{-%g}'        ,log10(h/100000)));
title('Analytical and central difference approximations');
hold off;
