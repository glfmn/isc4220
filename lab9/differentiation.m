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
