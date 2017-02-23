%% LU Decomposition and Gauss-Seidel
% 
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Calculating the Inverse with LU Decomposition
clear

% Define matrix A according to the problem
A = [6 15 55;15 55 225;55 225 979];

% Decompose matrix A
[ L, U, P ] = lu(A);

B = eye(size(A));
X = zeros(size(A));

for i = 1:size(A,2)
    for k =1:50
        X(i,:) = U\(L\B(:,i));
    end
end

% Check to see if proper inverse was calculated
X
inv(A)

%% Gauss-Seidel to reduce the residual
clear

% Deifine matrix A and vector b according to the problem
A = [0.80 -0.40 0.00;-0.40 0.80 -0.40;0.00 -0.40 0.80];
b = [41 25 105]';
x = zeros(size(b));

convergence = @(x0,x) norm(x0-x,2) < 0.01;

gaussSolution  = gaussSeidel(A,b,x,25,convergence)
matlabSolution = b\A

%% The Hilbert Matrix
% The condition number of a matrix helps determine how much precision we
% loose when solving matricies.
clear

% Define the hilbert Matrix as A
size = 4;
A = zeros(size);
% a_ij = 1/(i+j-1)
for i=1:size;
    for j=1:size;
        A(i,j) = 1 / (i+j-1);
    end
end

condition = cond(A,1)

%%%
% We loose four digits of precision because the condition number has order
% 10^4.
%
% The largest value in each row of the hilbert matrix is just the first
% element of the row due to the way the hilbert matrix is defined (lower j
% results in higher value for a_ij).

for i=1:size
    A(i,:) = A(i,:)/A(i,1);
end

conditionScaled = cond(A,1)

%%%
% Scaling each row does in fact reduce the condition number, but not enough
% to recover more digits of precision, as the condition number still has
% order 10^4.
