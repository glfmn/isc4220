function [ x, L, U, D ] = jacobi(A, b, x, iter)

if nargin < 4, iter = 25; end

L = tril(A,-1);
D = diag(diag(A));
U = triu(A,1);

jac = @(x) inv(D) * (b - (L + U) * x);

for i = 1:iter, 
    fprintf('\n\n%g:',i);
    x = jac(x)
end

end
