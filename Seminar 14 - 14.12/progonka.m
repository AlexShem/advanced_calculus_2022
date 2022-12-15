%% Parameters
n = 4;
M = diag(2*ones(n, 1)) + ...
    diag(.5*ones(n-1, 1), 1) + ...
    diag(.25*ones(n-1, 1), -1);

rng(123)
F = rand(n, 1);

%% alpha beta
alpha = zeros(n, 1);
beta = zeros(n, 1);

alpha(1) = -M(1, 2) / M(1, 1);
beta(1) = F(1) / M(1, 1);

for k = 2 : n
    if k == n
        alpha(k) = 0;
    else
        alpha(k) = -M(k, k+1)/(M(k, k-1)*alpha(k-1) + M(k, k));
    end
    beta(k) = (F(k) - M(k, k-1) * beta(k-1)) / (M(k, k-1)*alpha(k-1) + M(k, k));
end

%% Solution x
x = zeros(n , 1);
x(end) = beta(end);
for k = n-1 : -1 : 1
    x(k) = alpha(k)*x(k+1) + beta(k);
end

%% Validation
[M*x, F]

max(abs(M*x - F))
% max(abs(M * (M \ F) - F))
