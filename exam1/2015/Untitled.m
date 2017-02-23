% Create the circuitry matrix as modeled in the problem

A = -2*eye(6) + diag(ones(5,1),1) + diag(ones(5,1),-1);
b = -0.01*ones(6,1);
b(1) = b(1) - 2;
b(6) = b(6) - 3;