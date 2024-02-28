% initial approximations and function values
p0 = 0;
p1 = pi/2 - 0.1;
q0 = f(p0);
q1 = f(p1);

% tolerance
TOL = 10^(-3);

% maximun # of iterations
N0 = 50;

% output
p = 0;

% false position algorithm
i = 2;
while i <= N0

    % compute next approximated root
    p = p1 - q1 * (p1 - p0) / (q1 - q0);

    % determine whether the procedure was successful
    if rel_dif(p1, p) < TOL
        fprintf("The procedure was successful.\n Root is %f\n", p);
        return;
    end

    % prepare for next iteration
    i = i + 1;
    q = f(p);
    if (q * q1) < 0
        p0 = p1;
        q0 = q1;
    end
    p1 = p;
    q1 = q;
end

fprintf("The procedure was failed.");

function val = f(x)
    val = tan(x) - exp(x);
end

function dif = rel_dif(x1, x2)
    dif = abs(x2-x1)/abs(x1);
end