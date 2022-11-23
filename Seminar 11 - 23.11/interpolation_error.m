n = 12;
x_val = linspace(-1, 1, n); % Uniform grid
% x_val = cos((2*(n:-1:1) - 1)*pi/(2*n)); % Chebyshev grid

rng(10);
eps = (rand(1, n) - .5) * 2; % Error (-1, 1)
y_true = randi(10, 1, n);
y_val = y_true + eps;

L_i = @(x, i) prod(...
    (x - x_val(1:n ~= i)) ./ ...
    (x_val(i) - x_val(1:n ~= i)),...
    2);

%% Lagrange interpolation
x = linspace(min(x_val), max(x_val), 501).';
y = zeros(size(x));

figure(1);
for i = 1 : n
    y_i = y_val(i) * L_i(x, i);
    y = y + y_i;
    pl = plot(x, y_i); hold on;
    sc = scatter(x_val(i), y_val(i), 60, 'LineWidth', 1, ...
        'MarkerFaceColor', pl.Color, 'MarkerEdgeColor', 'none');
    sc.HandleVisibility = 'off'; % Don't show the scatter points in (future) legend
    sct = scatter(x_val(i), y_true(i), 60, '+', 'LineWidth', 1, ...
        'MarkerEdgeColor', pl.Color);
    sct.HandleVisibility = 'off';
end
plot(x, y, '--k', 'LineWidth', 1.5);
hold off;
legend('$L_1$', '$L_2$', '$L_3$', '$L_4$', '$L$', ...
    Interpreter = 'latex', FontSize = 14)
xlabel('$x$', Interpreter = 'latex', FontSize = 14)
title('Lagrange interpolation')

%% Error study
F = zeros(size(x));
F_crude = zeros(size(x));
for i = 1 : n
    F = F + eps(i) * L_i(x, i);
    F_crude = F_crude + abs(L_i(x, i));
end

figure(2);
plot(x, abs(F), x, F_crude)
legend('Actual error', 'Maximum possible error')
xlabel('$x$', Interpreter = 'latex', FontSize = 14)
title('Lagrange interpolation error');
subtitle('with uncertain initial conditions')

