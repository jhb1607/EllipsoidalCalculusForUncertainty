function X = sampleEllipsoidBoundary(P, c, N)
% sampleEllipsoidBoundary - Sample N points from the boundary of an ellipsoid
%
% Inputs:
%   P - positive definite matrix (n x n)
%   c - center vector (n x 1)
%   N - number of points to sample
%
% Output:
%   X - (N x n) matrix, each column is a sampled point on the ellipsoid boundary

    n = length(c);

    % Inverse square root of P (V, eig is same as sqrtm())
    [V, D] = eig(P); % Alternatively, chol(P)\eye(n) if speed is important
    A = V * diag(1./sqrt(diag(D))) * V';
    % Sample points uniformly from the unit sphere
    U = randn(n, N);
    U = U ./ vecnorm(U);  % Normalize columns to have norm 1

    % Map points to the ellipsoid boundary
    X = c + A * U;
    X = X';
end
