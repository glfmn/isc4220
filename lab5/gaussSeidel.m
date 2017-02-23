function [ result, its, x ] = gaussSeidel( A, b, x, iter, converge, log )
%GAUSSSEIDEL iterative method for solving linear equations; converges
%   quickly but is not guaranteed to converge in all cases.
%
%   x = GAUSSSEIDEL(A,b,x) where A is a square matrix, b is the result
%   vector, and x is the initial guess for the solution vector, will finish
%   either when converge() evaluates to true, or afer 25 iterations.  See
%   convergence details below.
%   GAUSSSEIDEL(A,b) uses inital guess x = zeros(size(b))
%   GAUSSSEIDEL(A,b,x,maxIt) will exit after performing maxIt iterations
%   GAUSSSEIDEL(A,b,x,maxIt,converge) allows the user to define a
%   custom convergence function.  See convergence details below for default
%   convergence critera.
%   [ x its ] = GAUSSSEIDEL(...) will return the result and number of
%   iterations the algorithm performed.
%   [ x its X ] = GAUSSSEIDEL(...) will return a matrix X containing all of
%   the iterations performed to calculate the result.
%
%   Convergence criteria default to: 
%
%       norm(x - x0,2) <= 10^-5 * x
%
%   The convergence test passes the current result vector and the previous
%   result vector, and expects a booleon value as a result.
%   Prints warnings in cases where gaussSeidel may not converge, I.E. when
%   A is not symetric-positive definite, or stritcly diagonally dominant,
%   or when the matrix has a zero diagonal element.

%%% Set defaults for variadic arguments
if nargin < 3, x(:,1)   = zeros(size(b));                    end
if nargin < 4, iter     = 25;                                end
if nargin < 5, converge = @(xk,x) norm(xk-x,2) <= 10^-5 * x; end
if nargin < 6, log      = true;                              end

% Test for convergence criteria:
willconv = @(A)   diagDom(A) || symDef(A);
% Tests to ensure a square matrix
under    = @(A)   size(A,1) < size(A,2);
over     = @(A)   size(A,1) > size(A,2);
% Tests to ensure A and b match dimenisions.
dim      = @(A,b) size(A,2) ~= size(b,1);

%%% Issue warnings
if ~noZeroDiag(A), warning('System needs non-zero diagonals'); end
if ~willconv(A),   warning('System may not converge');         end
if under(A),       warning('System is under-constrained');     end
if over(A),        warning('System is over-constrained');      end
if dim(A,b),       warning('Inner dimmensions mismatch');      end

%%% Implement algorithm
L     = tril(-A,-1);
U     = triu(-A,1);
gauss = @(L,D,U,x,b) inv(L+D) * (b-U*x);

%%% Perform iterations
its       = 0;
converged = false;

for its=1:iter;
    x(:,its+1) = gauss(L,D,U,x(:,its),b);
    if converge( x(:,its+1),x(:,its) ), converged=true; break; end
end

% Check convergence to warn the caller
if ~converged, warning('System did not converge.'); end

result = x(:,its);

end

%%
function [ bool ] = noZeroDiag( M, k )
%NOZERODIAG returns false if any zero elements are found on the kth
%    diagonal.

if nargin < 2, k=0; end

bool = true;

for i=1:size(M,1)
    if M(i,i+k) == 0, bool = false; break; end
end

end

%%
function [ bool ] = diagDom( M, k )
%DIAGDOM checks strict diagonal dominance along the kth diagonal of M
%   Expects a matrix M and integer k where k determines the diagonal to
%   use test.
%
%   Strict diagonal dominance is defined as: sum(a_ii) > sum(a_i) - a_ii

if nargin < 2, k=0; end

bool = true;

for i=1:size(M,1)
    if M(i,i+k) > sum(M(i,:))-M(i,i+k), bool = false; break; end
end

end

%%
function [ bool ] = symDef( M )
% SYMDEF checks if M is symetric-positive definite.

bool = false;

% TODO: implement symDef()

end