function [ x, A ] = gaussEl( A, b )
%GAUSSEL performs egaussian elimination with partial pivoting.
%   Edits matrix A in place to save memory and allow the algorithm to run
%   more effciently.  Partial pivoting reduces error with minimal impact on
%   efficiency.

if size(A,1) <  size(A,2), warning('\nUnder-constrained system\n');     end
if size(A,1) >  size(A,2), warning('\nOver-constrained system\n');      end
if size(A,1) ~= size(A,2), warning('\nRequires a square matrix\n');     end
if size(A,1) ~= size(b,1), warning('\nMatrix inner-bounds mismatch\n'); end

A = A * pivot(A);

elimination = @(e1,e2,n) e2 - (e2(n)/e1(n)).*e1;

for i = 2:size(A,2)
    for j = 1:(i-1)
        A(i,:) = elimination(A(j,:),A(i,:),j);
    end
end

if cond(A) > 10^4, 
    warning('\n\nMatrix is still poorly conditioned after pivoting\n\n');
    fprintf('Condition number is %g', cond(A));
end

x = 0