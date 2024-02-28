format long;

syms x h;
f(x) = cos(x);
N1(x, h) = (f(x+h) - f(x))/h;

h0 = 3 * 10^(-8);
a = -sin(0.25);
b = double(N1(0.25,h0));
e = rel_error(a, b);

fprintf("f'(0.25) is: %.15f\n", a);
fprintf("estimated value is: %.15f\n", b);
fprintf("relative error is: %.15e\n\n", e);

h0 = 10^(-17);
b = double(N1(0.25,h0));
e = rel_error(a, b);

fprintf("f'(0.25) is: %.15f\n", a);
fprintf("re-estimated value is: %.15f\n", b);
fprintf("relative error is: %.15e\n", e);

function e = rel_error(real_val, estimated_val)
    e = abs((real_val - estimated_val) / estimated_val);
end
