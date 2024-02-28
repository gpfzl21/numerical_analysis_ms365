% Set our function
syms x
f(x) = x^4 - 4*x^2 - 3*x + 5;

% 1st. Apply Newton's method
p0 = 1;         % initial approx
TOL = 10^(-3);  % tolerance
N0 = 50;        % max # of iteration

s1 = newton_method(f, p0, TOL, N0);

% 2nd Apply Newton's method
p0 = 2;         % initial approx
TOL = 10^(-3);  % tolerance
N0 = 50;        % max # of iteration

s2 = newton_method(f, p0, TOL, N0);

% 3rd. Apply Horner's method.
% We'll apply it two times since we found 2 real values.
% f(x) = (x-s1)q1(x) and q1(x) = (x-s2)q2(x)
q1(x) = horner_method(f, s1);
q2(x) = horner_method(q1, s2);

% 4th Apply Muller's method.
p0 = 1;
p1 = -1;
p2 = i;
TOL = 10^(-3);  % tolerance
N0 = 50;        % max # of iteration

s3 = muller_method(q2, p0, p1, p2, TOL, N0);
s4 = conj(s3);

% 5th. display our solutions
fprintf("Here is the solutions for the given functions:\n");
disp(s1);
disp(s2);
disp(s3);
disp(s4);



function dif = rel_dif(x1, x2)
    dif = abs(x2-x1)/abs(x1);
end

function p = newton_method(f, p0, TOL, N0)
    i = 1;
    Df = diff(f);
    while i <= N0
        p = p0 - f(p0)/Df(p0);  % compute p

        % Check whether the process successes.
        if rel_dif(p0, p) < TOL
            p = double(p);
            break;
        end
        i = i + 1;
        p0 = p;
    end
    
    if i > N0
        fprintf("The procedure was unsuccessful.\n");
        return;
    end
end

function q = horner_method(p, x0)
    syms x;
    n = polynomialDegree(p, x);
    C = flip(sym2poly(p));
    b = C(n+1);
    q = b * x^(n-1);
    while n > 1
        n = n - 1;
        b = C(n+1) + b*x0;
        q = q + b * x^(n-1);
    end
end

function p = muller_method(f, p0, p1, p2, TOL, N0)
    h1 = p1 - p0;
    h2 = p2 - p1;
    d1 = (f(p1) - f(p0)) / h1;
    d2 = (f(p2) - f(p1)) / h2;
    d = (d2 - d1) / (h2 + h1);
    i = 3;

    while i <= N0
        b = d2 + h2*d;
        D = sqrt(b^2 - 4*f(p2)*d);
        E = b - D;
        if double(abs(b - D)) < double(abs(b + D))
            E = b + D;
        end
        h = -2 * f(p2) / E;
        p = p2 + h;

        % Check whether the process successes.
        if double(abs(h)) < TOL
            p = double(p);
            break;
        end

        p0 = p1;
        p1 = p2;
        p2 = p;
        h1 = p1 - p0;
        h2 = p2 - p1;
        d1 = (f(p1) - f(p0)) / h1;
        d2 = (f(p2) - f(p1)) / h2;
        d = (d2 - d1) / (h2 + h1);
        i = i + 1;
    end

    if i > N0
        fprintf("The procedure was unsuccessful.\n");
        return;
    end
end

