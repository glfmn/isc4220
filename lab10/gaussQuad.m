function [ I, w ] = gaussQuad( f, a, b, n )
%GAUSSQUAD estimates integrals with gauss quadrature.
%
%   GAUSSQUAD(f,n) integrate function f between 0 and 1 with n nodes
%   GAUSSQUAD(f,a,b) integrate funtion f between a and b with four nodes
%   GAUSSQUAD(f,a,b,n) integrate function f between a and b with n nodes
%
%   [I, w]= GAUSSQUAD(...) I is the estimate of the integral of f and w are
%   the weights calculated in the problem.
%
%   Adapted from:
%       Trefethen, "Is Gauss Quadrature better than Clenshaw-Curtis?" as
%       presented in class notes for ISC4220, with Sachin Shanbhag

if exist('f','var') == 0, error('Must provide function to integrate'); end
if nargin < 3,            n = a; a = 0;                                end
if exist('a','var') == 0, a = 0;                                       end
if exist('b','var') == 0, b = 1;                                       end
if exist('n','var') == 0, n = 4;                                       end
if isnan(a) || isnan(b),  error('nan in integraiton bounds');          end
if isinf(a) || isinf(b),  error('inf in integraiton bounds');          end

t = @(x) ((b-a).*x + a+b) / 2;

% 3-term recurrence coeffs
beta = .5./sqrt(1-(2*(1:n)).^(-2));

% Jacobi matrix
T = diag(beta,1) + diag(beta,-1);

[V,D] = eig(T);   % eigenvalue decomposition
x     = diag(D);
[x,i] = sort(x);  % nodes (= Legendre points)

w = 2*V(1,i).^2;  % weights

I = w*feval(f,t(x)); % the integral

end
