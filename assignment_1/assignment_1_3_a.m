% problem 3-(a)-(i)
p0 = 11.6;
for c = 1:4
    fprintf("Iteration %d\n", c);
    p = x_minus_fun1(p0);
    p0 = p;
    fprintf("Aprroximated point is %f\n", p0);
    fprintf("Function value at that point is %f\n\n", fun1(p0));
end

fprintf("\n\n")

% problem 3-(a)-(ii)
p0 = 11.6;
for c = 1:4
    fprintf("Iteration %d\n", c);
    p = x_minus_fun2(p0);
    p0 = p;
    fprintf("Aprroximated point is %f\n", p0);
    fprintf("Function value at that point is %f\n\n", fun2(p0));
end





function val = fun1(x)
    val = 2552 - 30*x^2 + x^3;
end

function val = x_minus_fun1(x)
    val = x - fun1(x);
end

function val = fun2(x)
    val = (2552 - 30*x^2 + x^3)/(-300);
end

function val = x_minus_fun2(x)
    val = x - fun2(x);
end

