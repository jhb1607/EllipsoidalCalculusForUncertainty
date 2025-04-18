function plot_ellipse_with_points(A,c, P, varargin)

    % Plot ellipse
    figure;
    hold on;
    plot_ellipse(A, c, 'b');  % Blue ellipse

    % Scatter points
    scatter(P(:,1), P(:,2), 10, 'r', 'filled');

    xlim([-2 2]);
    ylim([-2 2]);

    title('Ellipse with Scatter Points');
    axis equal;
    grid on;
end