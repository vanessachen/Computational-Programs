x = 1 : 300;
curve1 = log(x);
curve2 = 2*log(x);
plot(x, curve1, 'r', 'LineWidth', 2);
hold on;
plot(x, curve2, 'b', 'LineWidth', 2);
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'g');