function X = sampleEllipsoidInterior(P, c, N)
% sampleEllipsoidInterior - Sample N points uniformly from inside an ellipsoid
%
% Inputs:
%   P - positive definite matrix (n x n)
%   c - center vector (n x 1)
%   N - number of points to sample
%
% Output:
%   X - (N x n) matrix, each row is a sampled point inside the ellipsoid

    n = length(c);

    % Inverse square root of P using eigen decomposition
    [V, D] = eig(P);
    A = V * diag(1 ./ sqrt(diag(D))) * V';

    % Sample points uniformly from the unit ball
    U = randn(n, N);
    U = U ./ vecnorm(U);  % Normalize to sphere

    % Scale radius with volume-preserving distribution
    R = rand(1, N).^(1/n);
    U = U .* R;  % Scale to unit ball

    % Map to ellipsoid interior
    X = c + A * U;
    X = X';
end

