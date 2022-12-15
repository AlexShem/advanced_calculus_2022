%% Parameters
f_fun = @(x) -(mod(x + pi, 2*pi) - pi) / 2; % -x/2

x = linspace(-2*pi + 1e-6, 2*pi - 1e-6, 50001);
f = f_fun(x);

%% Computation
n = 9;
f_ser = 0;
for k = 1 : n
    f_ser = f_ser + (-1)^k/k * sin(k*x);
end

%% Visualisation
figure(2)
plot(x, f);
hold on;
plot(x, f_ser);
hold off;
grid on;
xlabel('$x$', interpreter = 'latex', fontsize = 14)
legend('$f(x)$', 'Fourier', interpreter = 'latex', fontsize = 12)
title(['$n =$ ', num2str(n)], interpreter = 'latex', fontsize = 16)
