%% Optimization
clear

% Implement function according to specifications
f = @(x1,x2) 0.5*(x1.^2 - x2).^2 + 0.5*(1 - x1).^2;

% Plot the contour function of f
[X, Y] = meshgrid(-2:0.1:2);
Z      = f(X,Y);
contour(X,Y,Z);

gradient = @(x1,x2) [2*x1.^3+x1-2*x1.*x2; x2-x1.^2];

dfdx11 = @(x1,x2) 6*x1.^2-2*x2+1;
dfdx12 = @(x1,x2) -2*x1;
dfdx22 = @(x1,x2) 1;

hessian  = @(x1,x2) [dfdx11(x1,x2) dfdx12(x1,x2); dfdx12(x1,x2) dfdx22(x1,x2)];

xk = [0,0];
for n=1:2
    xk = xk + gradient(xk(1),xk(2))\hessian(xk(1),xk(2));
end