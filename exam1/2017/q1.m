%%% Question 1 part 3: Jacobi method

% Define the matrix according to the problem
A = [10 10000; 1 1];
b = [500; 1];

% Set initial Guess for x
x = [ 1; -1];
x_exact = [ 950; 49] / 999; % use for testing

jacobi(A, b, x, 3);

reverse = @(M) M([2,1],:);

A = reverse(A);
b = reverse(b);
x = reverse(x);

jacobi(A, b, x, 3);
