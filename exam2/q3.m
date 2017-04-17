%% Question 3: Interpolation
clear;
hold on;

runge = @(x) 1 / (1+(25.*x.^2));

xs = -1:0.2:1;
ys = arrayfun(runge,xs);
plot(xs,ys,'bo');

Me = vander(xs)
a  = Me\ys';

xs = -1:0.01:1
fs = arrayfun(@(x)polyval(a,x),xs);

plot(xs,fs,'b');

els = @(i) cos((2*i + 1) * pi / (2*numel(i)+2));
xs = els(0:10);
ys = arrayfun(runge,xs);
plot(xs,ys,'ro');

Mu = vander(xs)
a  = Mu\ys';

xs = -1:0.01:1;
fs = arrayfun(@(x)polyval(a,x),xs);

plot(xs,fs,'r');
plot(xs,arrayfun(runge,xs),'m');

legend('runge_e','p_e','runge_u','p_u','runge');

title('Equal space and Unequal space vandermonde interpolation');

fprintf('cond(M_u) = %g\n',cond(Mu));
fprintf('cond(M_e) = %g\n',cond(Me));

hold off;