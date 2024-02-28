syms s;
f(s) = s * sqrt(1 - s);

% original intergation value
int_val = double(int(f, s, 0, 1));
fprintf("intergration value is %.4f\n", int_val);

% Composite Trapezoidal rule
n = 600;  % note points are x_0, ..., x_n
h = 1 / n;

x_0 = f(0) + f(1);
x_1 = 0;    % summation of f(x_j)

for i = 1:n-1
    x = h * i;
    x_1 = x_1 + f(x);
end

approx_int_val = double (h * (x_0 + 2 * x_1) / 2);

fprintf("approximated value is %.4f\n", approx_int_val);
