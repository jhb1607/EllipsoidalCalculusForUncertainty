function plot_multiple_ellipses_with_points(P, Ps, Cs, alphas)
%PLOT_MULTIPLE_ELLIPSES_WITH_POINTS Plot ellipses from multiple alpha-levels
%   P     — N×2 data points
%   Ps    — 2×2×L ellipsoid matrices
%   Cs    — 2×L   centers
%   alphas — 1×L  vector of alpha levels (0.1, ..., 1.0)

    figure;
    hold on;

    % Scatter the data points
    scatter(P(:,1), P(:,2), 10, 'r', 'filled');

    % Define a color map
    cmap = turbo(length(alphas)); % or use lines, jet, etc.

    % Plot all ellipses
    for i = 1:length(alphas)
        A = Ps(:,:,i);
        c = Cs(:,i);
        plot_ellipse(A, c, 'Color', cmap(i,:), 'LineWidth', 1.2);
    end

    xlim([-2 2]);
    ylim([-2 2]);
    title('Ellipsoids at Different Confidence Levels');
    axis equal;
    grid on;
end
