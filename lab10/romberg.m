function [ I, Is, converged, n ] = romberg(f,a,b,conv,maxN)
%ROMBERG numerical integration with successive refinement
%
%   Using the trapezoidal rule, ROMBERG will integrate the desired function
%   performing iterations to find the best value with roughly O(n^2) time
%   complexity.
%
%   ROMBERG(f,a,b) evaluates the integral of f between a and b where f is a
%   single variable function, and is defined between a and b.
%   ROMBERG(f,a,b,tol) will exit early if the absolute error between
%   successive trials is less than tol; see default convergence below
%   ROMBERG(f,a,b,converge) will exit early when convege(previous,current)
%   evaluates to true; the default is shown below.
%   ROMBERG(...,maxIterations) exits algorithm early after performing the
%   desired maximum number of iteratinos.
%
%   [I, Is, converged, n] = ROMBERG(...) where:
%   I - the numerical estimate of the integral, 
%   Is - the vector of successive values used to estimate I
%   converged is a booleon which reports if the algorithm converged
%   n - the numer of iterations the algorithm performed
%
%   Default convergence criteria:
%       tol      = 1e-10
%       converge = @(t,u) abs(t - u) < abs(tol)
%   The leading error term for successive romberg integration is O(1/n^4)

% Apply defaults

if nargin < 5, maxN = 15;                                               end
% Define convergence criteria, setting tolerance to a default if and only
% if tolerance was not provided by the user
if nargin < 4 || isnumeric(conv), tol = conv; else tol = 1e-10;         end
if nargin < 4 || isnumeric(conv), conv = @(t,u) abs((t-u)) < abs(tol);  end

% Issue warnings & erorrs

if maxN < 1,                   error('invalid maximum iterations');     end
if isnan(f(a)) || isnan(f(b)), error('Improper bounds: nan at a or b'); end
if isinf(f(a)) || isinf(f(b)), error('Improper bounds: inf at a or b'); end

% Initialize values

% Define utility function to evaluate the integral with the trapezoid rule
% for n steps using matlab intrinsic functions
integrate = @(n) trapz(linspace(a,b,n),f(linspace(a,b,n)));

Is = zeros(1,maxN);
% Set the initial value for Is to the trapezoidal integral with 2 steps
Is(1) = integrate(2);

converged = false;
n = 1;

% Perform algorithm

for n = 2:maxN
    % Calculate the integral with 2n steps
    Is(n) = integrate(2*n);
    if isnan(Is(n)), error('nan on iteration %g', n); end
    if isinf(Is(n)), error('inf on iteration %g', n); end

    % Refine Integral calculations
    for m = n:-1:2
        d = 4^(n-m+1);
        Is(m) = (d*Is(m) - Is(m-1)) / (d-1);
    end

    I = Is(n); % Assign output

    % Check convergence
    if conv(Is(n-1),Is(n)), converged = true; break; end;
end

% Warn on exit if convergence criteria were never met
if ~converged, warning('Exited without converging'); end

end

