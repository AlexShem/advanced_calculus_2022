%% Parameters
x0 = 0;
x1 = 1;
u0 = 1;
u1 = exp(1/2);

% From 0 to 1
du0 = linspace(0, 1, 21);

%% Integration
figure(1)
for k = 1 : length(du0)
    z0 = [u0; du0(k)];
    [x, Z] = ode45(@(x, z) system_ODE(x, z), [x0 x1], z0);
    
    plot(x, Z(:, 1), '--k');
    hold on;
end
scatter(x1, u1, 50, "red", "filled")
hold off;

%% System of ODE
function dz = system_ODE(x, z)
dz = zeros(2, 1);
dz(1) = z(2);
dz(2) = (exp(x/2)*(x^2 + 0.75) - (x^2 + 1)*z(1))/(-1);
end
