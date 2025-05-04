% Add this to your Ellipsoid class methods section
function h = plotEllipsoid(obj, varargin)
% PLOT  Visualize the ellipsoid in 2D or 3D
%   h = obj.plot() plots the ellipsoid
%   h = obj.plot('PropertyName', PropertyValue, ...) customizes appearance
    
    % Parse optional inputs
    p = inputParser;
    p.addParameter('Color', [0.3 0.6 0.9], @(x) isnumeric(x) && length(x)==3);
    p.addParameter('Alpha', 0.5, @(x) isnumeric(x) && isscalar(x));
    p.addParameter('EdgeColor', 'none', @(x) ischar(x) || isnumeric(x));
    p.addParameter('EdgeAlpha', 0.7, @(x) isnumeric(x) && isscalar(x));
    p.addParameter('FaceColor', [], @(x) ischar(x) || isnumeric(x) || isempty(x));
    p.addParameter('Resolution', 30, @(x) isnumeric(x) && isscalar(x));
    p.parse(varargin{:});
    
    opts = p.Results;
    if isempty(opts.FaceColor)
        opts.FaceColor = opts.Color;
    end
    
    % Get dimension of the ellipsoid
    n = obj.getDims();
    
    % Get the eigendecomposition of shape matrix
    [V, D] = eig(obj.P);
    radii = 1 ./ sqrt(diag(D));
    
    % Generate points on unit sphere/circle
    res = opts.Resolution;
    if n == 2
        theta = linspace(0, 2*pi, res);
        unit_circle = [cos(theta); sin(theta)];
        
        % Transform unit circle to ellipse
        ellipse = V * diag(radii) * unit_circle;
        
        % Translate to center
        ellipse = ellipse + obj.c;
        
        % Plot as filled polygon
        h = fill(ellipse(1,:), ellipse(2,:), opts.FaceColor, ...
                'EdgeColor', opts.EdgeColor, ...
                'FaceAlpha', opts.Alpha, ...
                'EdgeAlpha', opts.EdgeAlpha);
    elseif n == 3
        [X, Y, Z] = sphere(res);
        unit_sphere = [X(:)'; Y(:)'; Z(:)'];
        
        % Transform unit sphere to ellipsoid
        ellipsoid = V * diag(radii) * unit_sphere;
        
        % Translate to center
        ellipsoid = ellipsoid + obj.c;
        
        % Reshape back to grid
        X = reshape(ellipsoid(1,:), size(X));
        Y = reshape(ellipsoid(2,:), size(Y));
        Z = reshape(ellipsoid(3,:), size(Z));
        
        % Plot surface
        h = surf(X, Y, Z, ...
                'FaceColor', opts.FaceColor, ...
                'EdgeColor', opts.EdgeColor, ...
                'FaceAlpha', opts.Alpha, ...
                'EdgeAlpha', opts.EdgeAlpha);
        lighting phong;
        camlight;
    else
        error('Visualization only supported for 2D and 3D ellipsoids');
    end
    
    % Make the plot look nice
    axis equal
    grid on
    hold on
    
    % Return the handle
    if nargout < 1
        clear h
    end
end