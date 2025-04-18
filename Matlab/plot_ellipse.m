function plot_ellipse(A, c, varargin)
%PLOT_ELLIPSE Plots a 2D ellipse defined by (x - c)' * A * (x - c) = 1
%   A — 2×2 positive definite matrix
%   c — 2×1 center
%   varargin — optional plot arguments like 'Color', 'LineWidth', etc.

    theta = linspace(0, 2*pi, 200);
    circle = [cos(theta); sin(theta)];

    [V, D] = eig(inv(A));              % Ellipsoid shape
    ellipse = V * sqrt(D) * circle;    % Transform unit circle
    ellipse = ellipse + c;             % Shift to center

    plot(ellipse(1, :), ellipse(2, :), varargin{:});
end
