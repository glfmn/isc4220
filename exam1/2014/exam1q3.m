%% Part 1:
A = [10.0 1.0; 3.0001 3.0];
b = [11; 3.3];

cond(A)

[L,U] = lu(A)



%% Part 3: cos Convergence

domain = 20;

% Initialize domain and range
xs = 1:domain;
ys = zeros(size(xs));

% Set initial value
ys(1) = rand();

% Recurse over cosine
for n=2:size(ys,2)
    ys(n) = cos(ys(n-1));
end

% Plot the result to demonstrate the convergence
plot(xs,ys)