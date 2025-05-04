function plotCoolCloud(varargin)
%PLOTCOOLCLOUDS Plot multiple 2D point clouds with clean styling
%
%   Usage:
%     plotCoolClouds(P1, P2, ..., PN)

    colors = lines(numel(varargin));  % distinct colors from MATLAB colormap
    hold on
    for i = 1:numel(varargin)
        P = varargin{i};
        scatter(P(:,1), P(:,2), 25, 'filled', 'MarkerFaceColor', colors(i,:));
    end
    axis equal
    grid on
    box on
    set(gca, 'Color', 'w', 'GridAlpha', 0.2, 'FontName', 'Helvetica')
    title('Pretty Pretty ✨', 'FontSize', 14, 'FontWeight', 'normal')
end
