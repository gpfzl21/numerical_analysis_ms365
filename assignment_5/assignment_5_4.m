syms t w1 w2;
f(t,w1,w2) = [w1*(4-0.0003*w1-0.0004*w2), w2*(2-0.0002*w1-0.0001*w2)];

h = 0.01;

[t_values, w1_values, w2_values] = RK4(h, f);
fprintf('----------------------------------------------------\n');
fprintf('RK4 method with h=%f:\n', h);
fprintf(['Since there are too many values, ' ...
    'just print values with interval length 1/10, i.e., ' ...
    'only print it once every 10 times\n']);
fprintf('Approximated w1 values are:\n');
disp(w1_values(1:10:end));
fprintf('Approximated w2 values are:\n');
disp(w2_values(1:10:end));
fprintf('----------------------------------------------------\n');
k = 30;
fprintf(['To see the convergence of w1 and w2 values clearly, ' ...
    'print last %d values\n'], k);
fprintf('Last %d approximated w1 values are:\n', k);
disp(w1_values(end-k+1:end));
fprintf('Last %d approximated w2 values are:\n', k);
disp(w2_values(end-k+1:end));

f1 = figure('Name','x-w1 graph');
plot(t_values, w1_values);
xlabel('t');
ylabel('w1');
f2 = figure('Name','x-w2 graph');
plot(t_values, w2_values);
xlabel('t');
ylabel('w2');

function [t_values, w1_values, w2_values] = RK4(h, f)
    % for speed, i did preallocation
    numbs = 4/h + 1;
    t_values = 0:h:4;
    w1_values = zeros(1, numbs);
    w2_values = zeros(1, numbs);

    t = 0;
    w1 = 10000;
    w2 = 10000;
    w1_values(1) = w1;
    w2_values(1) = w2;
    for i=2:numbs
        K1 = h * f(t,w1,w2);
        K2 = h * f(t+h/2, w1+K1(1)/2, w2+K1(2)/2);
        K3 = h * f(t+h/2, w1+K2(1)/2, w2+K2(2)/2);
        K4 = h * f(t+h, w1+K3(1), w2+K3(2));
        % put double for fast calculation
        w1 = w1 + double((K1(1)+2*K2(1)+2*K3(1)+K4(1))/6);
        w2 = w2 + double((K1(2)+2*K2(2)+2*K3(2)+K4(2))/6);
        t = t + h;

        w1_values(i) = w1;
        w2_values(i) = w2;
    end
end
