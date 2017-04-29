function [ ts, ys ] = shoot( o, a, b, i, f, tol )
%SHOOT shooting method for solving Boundary Value Problems in ODEs
%   Works for linear ODEs but traverses the domain 3 times to find the
%   solution.

%%% Check and handle input values

if exist('o','var') == 0,   error('must provide an ode function');      end
if isnumeric(o),            error('ode must be a function');            end
if ~isscalar(o),            error('ode must be a function');            end
if exist('a','var') == 0,   error('must provide a lower bound for t');  end
if exist('b','var') == 0,   error('must provide an upper bound for t'); end
if exist('i','var') == 0,   error('need iniital value function');       end
if isnumeric(i),            error('i must be a function');              end
if ~isscalar(i),            error('i must be a function');              end
if size(i()) ~= size(f),    error('i() return value of size(f)');       end
if exist('f','var') == 0,   error('no final value provided');           end
if ~iscolumn(f),            error('f must be a column vector');         end
if size(o(0,f)) ~= size(f), error('ode(t,f) return value of size(f)');  end
if exist('tol','var') == 0, tol = 10e-6;                                end

span = [a b];

%%% Shooting algorithm

[ ts, ys ] = ode45(o, span, i());

y = abs(ys(end,:)-f);
if ~isempty(y(y>tol)), warn('failed to converge'); end

end

