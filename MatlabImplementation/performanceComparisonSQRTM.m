%% Performance Comparison of Matrix Square Root Methods
% This script compares different methods for computing sqrtm(inv(P))
% for positive definite matrices of varying dimensions

% Dimensions to test
dimensions = [2, 3, 5, 8, 160, 800, 10000];

% Number of repetitions for reliable timing
num_trials = 5;

% Initialize results storage
results = struct('dimension', dimensions, ...
                'time_sqrtm', zeros(size(dimensions)), ...
                'time_eig', zeros(size(dimensions)), ...
                'time_chol', zeros(size(dimensions)), ...
                'time_svd', zeros(size(dimensions)), ...
                'error_eig', zeros(size(dimensions)), ...
                'error_chol', zeros(size(dimensions)), ...
                'error_svd', zeros(size(dimensions)));

fprintf('Comparing matrix square root methods for various dimensions...\n\n');
fprintf('%-10s %-15s %-15s %-15s %-15s %-15s %-15s %-15s\n', ...
        'Dimension', 'sqrtm (ms)', 'eig (ms)', 'chol (ms)', 'svd (ms)', ...
        'eig error', 'chol error', 'svd error');
fprintf('%-10s %-15s %-15s %-15s %-15s %-15s %-15s %-15s\n', ...
        '--------', '--------', '--------', '--------', '--------', ...
        '--------', '--------', '--------');

% Loop through each dimension
for i = 1:length(dimensions)
    n = dimensions(i);
    
    % Generate a random positive definite matrix
    A = randn(n, n);
    P = A' * A + eye(n) * 0.1;  % Ensure positive definiteness
    
    % Ensure symmetry (sometimes numerical issues can break symmetry)
    P = (P + P') / 2;
    
    % 1. Using sqrtm(inv(P)) - baseline
    t_sqrtm = 0;
    t_eig = 0;
    t_chol = 0;
    t_svd = 0;
    
    % Run multiple trials for timing
    for trial = 1:num_trials
        % Method 1: Direct sqrtm(inv(P))
        tic;
        M1 = sqrtm(inv(P));
        t_sqrtm = t_sqrtm + toc;
        
        % Method 2: Eigendecomposition
        tic;
        [V, D] = eig(P);
        M2 = V * diag(1./sqrt(diag(D))) * V';
        t_eig = t_eig + toc;
        
        % Method 3: Cholesky
        tic;
        L = chol(P);
        M3 = inv(L)';
        t_chol = t_chol + toc;
        
        % Method 4: SVD
        tic;
        [U, S, ~] = svd(P);
        M4 = U * diag(1./sqrt(diag(S))) * U';
        t_svd = t_svd + toc;
    end
    
    % Average times
    t_sqrtm = t_sqrtm / num_trials * 1000;  % Convert to milliseconds
    t_eig = t_eig / num_trials * 1000;
    t_chol = t_chol / num_trials * 1000;
    t_svd = t_svd / num_trials * 1000;
    
    % Calculate errors against sqrtm(inv(P))
    err_eig = norm(M1 - M2, 'fro') / norm(M1, 'fro');
    err_chol = norm(M1 - M3, 'fro') / norm(M1, 'fro');
    err_svd = norm(M1 - M4, 'fro') / norm(M1, 'fro');
    
    % Store results
    results.time_sqrtm(i) = t_sqrtm;
    results.time_eig(i) = t_eig;
    results.time_chol(i) = t_chol;
    results.time_svd(i) = t_svd;
    results.error_eig(i) = err_eig;
    results.error_chol(i) = err_chol;
    results.error_svd(i) = err_svd;
    
    % Display results
    fprintf('%-10d %-15.6f %-15.6f %-15.6f %-15.6f %-15.2e %-15.2e %-15.2e\n', ...
            n, t_sqrtm, t_eig, t_chol, t_svd, err_eig, err_chol, err_svd);
end

% Plot results
figure('Position', [100, 100, 1200, 500]);

% Plot 1: Computation time
subplot(1, 2, 1);
loglog(dimensions, results.time_sqrtm, 'o-', 'LineWidth', 2, 'DisplayName', 'sqrtm(inv(P))');
hold on;
loglog(dimensions, results.time_eig, 's-', 'LineWidth', 2, 'DisplayName', 'Eigendecomposition');
loglog(dimensions, results.time_chol, 'd-', 'LineWidth', 2, 'DisplayName', 'Cholesky');
loglog(dimensions, results.time_svd, '^-', 'LineWidth', 2, 'DisplayName', 'SVD');
grid on;
xlabel('Matrix Dimension');
ylabel('Computation Time (ms)');
title('Computation Time vs. Matrix Dimension');
legend('Location', 'NorthWest');
set(gca, 'XScale', 'log', 'YScale', 'log');

% Plot 2: Relative Error
subplot(1, 2, 2);
semilogx(dimensions, results.error_eig, 's-', 'LineWidth', 2, 'DisplayName', 'Eigendecomposition');
hold on;
semilogx(dimensions, results.error_chol, 'd-', 'LineWidth', 2, 'DisplayName', 'Cholesky');
semilogx(dimensions, results.error_svd, '^-', 'LineWidth', 2, 'DisplayName', 'SVD');
grid on;
xlabel('Matrix Dimension');
ylabel('Relative Error');
title('Numerical Error vs. Matrix Dimension');
legend('Location', 'Best');
set(gca, 'XScale', 'log');

% Function to check if a matrix is symmetric
function is_sym = isSymmetric(A, tol)
    if nargin < 2
        tol = 1e-10;
    end
    is_sym = norm(A - A', 'inf') < tol;
end

% Function to check if a matrix is positive definite
function is_pd = isPositiveDefinite(A)
    try
        chol(A);
        is_pd = true;
    catch
        is_pd = false;
    end
end