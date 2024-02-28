syms t w;
f(t,w) = 1 + w/t;
y(t) = t*log(t) + 2*t;

for h=[1/10, 1/20, 1/40]
    [~, y_values] = Exact_Values(h, y);
    [t_values, w_values] = Adams_4th_Order_Predictor_Corrector(h, f);
    [error_values, max_error] = Error(y_values, w_values);
    fprintf('----------------------------------------------------\n');
    fprintf('Adams 4th-order predictor-corrector method with h=1/%d:\n', 1/h);
    fprintf('Approximated values are:\n');
    disp(w_values)
    fprintf('Absolute errors for each values are\n');
    disp(error_values);
    fprintf('Maximum absolute error is: %e\n', max_error)
end

% last t_values and error_values are saved
% they are values associated with h=1/40
plot(t_values, error_values)
xlabel('t');
ylabel('error');

function [t_values, w_values] = Adams_4th_Order_Predictor_Corrector(h, f)
    % for speed, i did preallocation
    numbs = 1/h + 1;
    t_values = 1:h:2;
    w_values = zeros(1, numbs);

    t = 1;
    w = 2;
    w_values(1) = w;

    % RK4 for starting values
    for i=2:4
        K1 = h * f(t,w);
        K2 = h * f(t+h/2, w+K1/2);
        K3 = h * f(t+h/2, w+K2/2);
        K4 = h * f(t+h, w+K3);
        w = w + (K1+2*K2+2*K3+K4)/6;
        t = t + h;

        w_values(i) = w;
    end

    % Set starting pts
    f0 = f(t_values(1), w_values(1));
    f1 = f(t_values(2), w_values(2));
    f2 = f(t_values(3), w_values(3));
    f3 = f(t_values(4), w_values(4));
    w3 = w_values(4);

    % Do predictor corrector method
    for i=5:numbs
        t = t + h;
        % predict w_i
        w = w3 + h*(55*f3-59*f2+37*f1-9*f0)/24;
        % correct w_i
        fw = f(t, w);
        w = w3 + h*(9*fw+19*f3-5*f2+f1)/24;

        w_values(i) = w;

        % reset values for iteration
        f0 = f1;
        f1 = f2;
        f2 = f3;
        f3 = fw;
        w3 = w;
    end
end

function [t_values, y_values] = Exact_Values(h, y)
    % for speed, i did preallocation
    numbs = 1/h + 1;
    t_values = 1:h:2;
    y_values = zeros(1, numbs);

    t = 1;
    for i=1:numbs
        y_values(i) = y(t);
        t = t + h;
    end
end

function [error_values, max_error] = Error(exact_values, approx_values)
    error_values = abs(exact_values - approx_values);
    max_error = max(error_values);
end
