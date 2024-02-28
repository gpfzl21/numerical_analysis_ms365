syms s t u;
f(s,t,u) = s*t*sin(t*u);

% original intergation value
int_val = int(f, s, 0, pi);
int_val = int(int_val, t, 0, pi/2);
int_val = int(int_val, u, 0, pi/3);
fprintf("intergration value is %.12f\n", int_val);

% composite gaussian quadrature
x(1) = 0.7745966692;
x(2) = 0;
x(3) = -x(1);
c(1) = 0.5555555556;
c(2) = 0.8888888889;
c(3) = c(1);

X = linspace(0, pi, 3);
Y = linspace(0, pi/2, 3);
Z = linspace(0, pi/3, 3);
approx_int_val = 0;

% For s-axis
for j = 1:2
    g(s,t,u) = f(((X(j+1)-X(j))*s+(X(j+1)+X(j)))/2,t,u)*(X(j+1)-X(j))/2;
    for i = 1:3
        approx_int_val = approx_int_val + c(i)*g(x(i),t,u);
    end
end
f(t,u) = approx_int_val;
approx_int_val = 0;

% For t-axis
for j = 1:2
    g(t,u) = f(((Y(j+1)-Y(j))*t+(Y(j+1)+Y(j)))/2,u)*(Y(j+1)-Y(j))/2;
    for i = 1:3
        approx_int_val = approx_int_val + c(i)*g(x(i),u);
    end
end
f(u) = approx_int_val;
approx_int_val = 0;

for j = 1:2
    g(u) = f(((Z(j+1)-Z(j))*u+(Z(j+1)+Z(j)))/2)*(Z(j+1)-Z(j))/2;
    for i = 1:3
        approx_int_val = approx_int_val + c(i)*g(x(i));
    end
end

fprintf("approximated value is %.12f", approx_int_val);
