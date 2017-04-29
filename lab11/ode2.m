function [ts, ys] = ode2(o, a, h, b, y)
%ODE2 Solve differential equations with midpoint method
%   Integrates the function ODE across uniform timesteps taking O(n) time.
%
%   ODE2(ODE,T0,DT,TMAX,Y0) integrates the function ODE across unifrom
%   timesteps DT from T0 to TMAX.
%   ODE must be a function handle where size(ODE(t,y)) == Y0
%   Y0 must be a column vector
%   T0, DT, TMAX are scalar values
%
%   [ts, ys] = ODE2(...) outputs a vector of the ts used and a matrix ys of
%   y values at each step where:
%   - each column corresponds to a variable
%   - y(1,:) == y0
%   - the number of rows is the same as numel(ts).
%   ts == colon(a,h,b) == a:h:b
%
%   Example: the velocity and position over time of a mass on a spring with 
%   initial position of 1 and initial velocity of 0.
%
%   f = @(t,y) [ y(2); -(0.5*y(2)+y(1))]; y0 = [1; 0];
%   [ts, ys] = ODE2(f, 0, 0.1, 4*pi, y0);
%   plot(ts,ys); legend('position','velocity');

if exist('o','var') == 0,   error('Must provide an ode function');      end
if isnumeric(o),            error('ode must be a function');            end
if exist('a','var') == 0,   error('Must provide a final value');        end
if exist('b','var') == 0,   error('Must provide an initial value');     end
if exist('h','var') == 0,   error('Must provide a stepsize');           end
if exist('y','var') == 0,   error('must provide initial conditions');   end
if ~iscolumn(y),            error('y0 must be a column vector');        end
if size(o(0,y)) ~= size(y), error('size(ode(t,y)) must equal size(y)'); end

%%% Calculate t values from bounds and stepsize as column vector

ts = colon(a,h,b)';

%%% Preallocate output

sz = size(y);
ys = zeros( [numel(ts), sz(1)] );
% Add initial values to output matrix
ys(1,:) = y';
clear y;

%%% Define algorithm to calculate midpoint step

mid  = @(ys,n) ys(n,:)' + h/2 .* o(ts(n), ys(n,:)');
next = @(ys,n) ys(n,:)' + h   .* o(ts(n) + h/2, mid(ys,n));

%%% Walk the initial value problem using midpoint method
for n = 1:numel(ts)-1, ys(n+1,:) = next(ys,n); end
