function [P, c] = fitEllipsoidMomentsND(points, alpha)
%FITELLIPSOIDMOMENT S Fit an n‑D ellipsoid via first & second moments
%   [P, c] = fitEllipsoidMomentsND(points, k)
%   points — N×n array of data
%   k      — (optional) scaling factor; default = n+1
%
%   Returns P (n×n) and center c (n×1) such that
%     (x - c)' * P * (x - c) ≤ 1
%
    [N, n] = size(points);
    if nargin<2 || isempty(alpha)
        k = chi2inv(0.99, n);
    else 
        k = chi2inv(alpha, n);
    end

    % 1) center = mean of points
    c = mean(points,1)';       % n×1

    % 2) covariance (second central moment)
    X = points - c';           % N×n
    Sigma = (X' * X) / N;      % n×n

    % 3) eigendecomposition
    [V, D] = eig(Sigma);       % V: n×n eigenvectors, D: diag(λ_i)

    % 4) axis lengths li = sqrt(k * λ_i)
    lambda = diag(D);          % n×1
    l = sqrt(k * lambda);      % n×1

    % 5) build P = V * diag(1./l.^2) * V'
    P = V * diag(1 ./ (l.^2)) * V';

end
