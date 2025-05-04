function plotCoolCloud3D(varargin)
%PLOTCOOLCLOUD3D Plot multiple 3D point clouds with clean styling
%
% Usage:
% plotCoolCloud3D(P1, P2, ..., PN)
    colors = lines(numel(varargin)); % distinct colors
    hold on
    for i = 1:numel(varargin)
        P = varargin{i};
        scatter3(P(:,1), P(:,2), P(:,3), 25, 'filled', 'MarkerFaceColor', colors(i,:), 'MarkerFaceAlpha', 0.7);
    end
    axis equal
    grid on
    box on
    set(gca, 'Color', 'w', 'GridAlpha', 0.2, 'FontName', 'Helvetica')
    title('3D Pretty Pretty ✨', 'FontSize', 14, 'FontWeight', 'normal')
    
    % Better 3D view
    view(40, 30)
    camlight
    lighting phong
    
    % Optional: Add a subtle gradient background
    set(gcf, 'Color', [0.95, 0.97, 1])
end