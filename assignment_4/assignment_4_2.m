syms s;
f(s) = s * sqrt(1 - s);

% original intergation value
int_val = double(int(f, s, 0, 1));
fprintf("intergration value is %.4f\n", int_val);

% Composite adaptive Simpson’s rule
TOL = 10^(-7);
N = 50; % limit of levels

% Step 1
approx_int_val = 0;
i = 1;
TOLs(i) = 10 * TOL;
a(i) = 0;
h(i) = 1/2;
FA(i) = f(0);
FC(i) = f(h(i));
FB(i) = f(1);
S(i) = h(i)*(FA(i)+4*FC(i)+FB(i))/3; % Approx from Simpson's method
L(i) = 1;   % level

% Step 2
while i > 0
    % Step 3
    FD = f(a(i)+h(i)/2);
    FE = f(a(i)+3*h(i)/2);
    S1 = h(i)*(FA(i)+4*FD+FC(i))/6; % Approx for left subinterval
    S2 = h(i)*(FC(i)+4*FE+FB(i))/6;
    % save data at this level
    v1 = a(i);
    v2 = FA(i);
    v3 = FC(i);
    v4 = FB(i);
    v5 = h(i);
    v6 = TOLs(i);
    v7 = S(i);
    v8 = L(i);

    % Step 4
    i = i - 1;  % Delete the level

    % Step 5
    if abs(S1+S2-v7) < v6
        approx_int_val = approx_int_val + S1 + S2;
    else
        if v8 >= N  % level exceeds
            fprintf("LEVEL EXCEEDED");  % procedure fails
            return;
        else    % add one level
            % data for right-half subinterval
            i = i + 1;
            a(i) = v1 + v5;
            FA(i) = v3;
            FC(i) = FE;
            FB(i) = v4;
            h(i) = v5/2;
            TOLs(i) = v6/2;
            S(i) = S2;
            L(i) = v8 + 1;
            % data for left-half subinterval
            i = i + 1;
            a(i) = v1;
            FA(i) = v2;
            FC(i) = FD;
            FB(i) = v3;
            h(i) = h(i-1);
            TOLs(i) = TOLs(i-1);
            S(i) = S1;
            L(i) = L(i-1);
        end
    end
end

approx_int_val = double(approx_int_val);
fprintf("approximated value is %.4f\n", approx_int_val);
