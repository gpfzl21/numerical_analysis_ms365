format long;

syms x h;
f(x) = cos(x);
N3(x, h) = 1 / (3 * h) * (-21*f(x) + 32*f(x+h/4) - 12*f(x+h/2) + f(x+h));

h0 = 7.5 * 10^(-4);
a = -sin(0.25);
b = double(N3(0.25,h0));
e = rel_error(a, b);

fprintf("f'(0.25) is: %.15f\n", a);
fprintf("estimated value is: %.15f\n", b);
fprintf("relative error is: %.15e\n\n", e);

h0 = 10^(-5);
b = double(N3(0.25,h0));
e = rel_error(a, b);

fprintf("f'(0.25) is: %.15f\n", a);
fprintf("re-estimated value is: %.15f\n", b);
fprintf("relative error is: %.15e\n", e);

function e = rel_error(real_val, estimated_val)
    e = abs((real_val - estimated_val) / estimated_val);
end
