format long;

syms s;
f(s) = cos(s)^2;

% original intergation value
int_val = double(int(f, s, 0, pi/4));
fprintf("intergration value is %.12f\n", int_val);

% composite gaussian quadrature
x(1) = 0.7745966692;
x(2) = 0;
x(3) = -x(1);
c(1) = 0.5555555556;
c(2) = 0.8888888889;
c(3) = c(1);

n = 6;
for k = 3:n
    X = [linspace(0, pi/4, k)];
    approx_int_val = 0;
    for j = 1:k-1
        g(s) = f(((X(j+1)-X(j))*s+(X(j+1)+X(j)))/2)*(X(j+1)-X(j))/2;
        for i = 1:3
            approx_int_val = approx_int_val + c(i)*g(x(i));
        end
    end
    fprintf("approximated value is %.12f with %d intervals\n", ...
        approx_int_val, k-1);
end
