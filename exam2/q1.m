%% Q1: Interpolation and Approximation
clear

hold on;
c = [0.5 0.8 1.5 2.5 4.0];
k = [1.1 2.4 5.3 7.6 8.9];


xs = 0.5:0.01:9;
[ys, B] = dd(c,k,xs);
plot(xs,ys);

ps = pchip(c,k,xs);
plot(xs,ps);

k = 1\k;

A = [ones(size(k))' arrayfun(@(c)1/c.^2,c)'];

s = (A'*A)\(A'*k')

f = @(c) 1/s(1) + s(2)/(s(1)) * 1./(c.^2);

plot(xs,f(xs));
plot(c,k,'bo');

legend('divided differences','pchip','lls','data');

hold off;
