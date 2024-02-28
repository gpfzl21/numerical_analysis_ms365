format long;

syms s;
f(s) = cos(s)^2;

% original intergation value
int_val = double(int(f, s, 0, pi/4));
fprintf("intergration value is %.12f\n", int_val);

% Gaussian quadrature
g(s) = f((pi/4*s+pi/4)/2)*(pi/4)/2;

% n=2
x(2,1) = 0.5773502692;
x(2,2) = -x(2,1);
c(2,1) = 1;
c(2,2) = 1;

% n=3
x(3,1) = 0.7745966692;
x(3,2) = 0;
x(3,3) = -x(3,1);
c(3,1) = 0.5555555556;
c(3,2) = 0.8888888889;
c(3,3) = c(3,1);

% n=4
x(4,1) = 0.8611363116;
x(4,2) = 0.3399810436;
x(4,3) = -x(4,2);
x(4,4) = -x(4,1);
c(4,1) = 0.3478548451;
c(4,2) = 0.6521451549;
c(4,3) = c(4,2);
c(4,4) = c(4,1);

% n=5
x(5,1) = 0.9061798459;
x(5,2) = 0.5384693101;
x(5,3) = 0;
x(5,4) = -x(5,2);
x(5,5) = -x(5,1);
c(5,1) = 0.2369268850;
c(5,2) = 0.4786286705;
c(5,3) = 0.5688888889;
c(5,4) = c(5,2);
c(5,5) = c(5,1);

approx_int_vals = zeros(1, 5);
for n = 2:5
    for i = 1:n
        approx_int_vals(n) = approx_int_vals(n) + c(n,i)*g(x(n,i));
    end
end

for n = 2:5
    fprintf("approximated value is %.12f with order n=%d\n", ...
        approx_int_vals(n), n)
end
