classdef Ellipsoid
    properties
        P   % Shape matrix (positive definite)
        c   % Center vector
    end

    methods
        function obj = Ellipsoid(P, c)
            P = (P + P') / 2;  % Ensure symmetry
            if all(eig(P) > 0)
                obj.P = P;
                obj.c = c(:);  % Ensure column vector
            else
                error('Matrix P must be positive definite.');
            end
        end

        function e2 = mtimes(obj, r)
            % Scalar multiplication: E * r
            e2 = Ellipsoid(obj.P / r, obj.c);
        end

        function e2 = mrdivide(obj, r)
            % Scalar division: E / r
            e2 = obj * (1 / r);
        end

        function tf = contains(obj, x)
            % Check if point is inside ellipsoid
            x = x(:) - obj.c;
            tf = x' * obj.P * x <= 1;
         end

        function d = centerDistance(obj, other)
            % Distance between centers
            d = norm(obj.c - other.c);
        end

        function d = pointCenterDistance(obj, x)
            % Distance from point x to center
            d = norm(obj.c - x(:));
        end

        function n = getDims(obj)
            n = length(obj.c); 
        end
        
        function V = volume(obj)
            % Volume of the ellipsoid
            n = length(obj.c);
            V = pi^(n/2) / gamma(n/2 + 1) * sqrt(det(inv(obj.P)));
        end

        function e2 = scale(obj, alpha)
            % Scaled ellipsoid
            e2 = Ellipsoid(obj.P / alpha, obj.c * alpha);
        end

        function h = plot(obj, varargin)
        % PLOT  Visualize the ellipsoid in 2D or 3D
        %   E.plot() or E.plot('Color', [r g b], ...)
        
        % Parse optional inputs
        p = inputParser;
        addParameter(p, 'Color', [0.3 0.6 0.9], @(x) isnumeric(x) && length(x) == 3);
        addParameter(p, 'Alpha', 0.5, @(x) isnumeric(x) && isscalar(x));
        addParameter(p, 'EdgeColor', 'none', @(x) ischar(x) || isnumeric(x));
        addParameter(p, 'EdgeAlpha', 0.7, @(x) isnumeric(x) && isscalar(x));
        addParameter(p, 'FaceColor', [], @(x) isempty(x) || ischar(x) || isnumeric(x));
        addParameter(p, 'Resolution', 50, @(x) isnumeric(x) && isscalar(x));
        parse(p, varargin{:});
        opts = p.Results;
        if isempty(opts.FaceColor)
            opts.FaceColor = opts.Color;
        end
    
        % Eigendecomposition
        [V, D] = eig(obj.P);
        radii = 1 ./ sqrt(diag(D)); % Semi-axes
    
        res = opts.Resolution;
        n = obj.getDims();
        hold on;
        if n == 2
            theta = linspace(0, 2*pi, res);
            unit_circle = [cos(theta); sin(theta)];
            ellipse = V * diag(radii) * unit_circle + obj.c;
            h = fill(ellipse(1,:), ellipse(2,:), opts.FaceColor, ...
                'EdgeColor', opts.EdgeColor, ...
                'FaceAlpha', opts.Alpha, ...
                'EdgeAlpha', opts.EdgeAlpha);
        elseif n == 3
            [X, Y, Z] = sphere(res);
            unit_sphere = [X(:)'; Y(:)'; Z(:)'];
            ellipsoid = V * diag(radii) * unit_sphere + obj.c;
            X = reshape(ellipsoid(1,:), size(X));
            Y = reshape(ellipsoid(2,:), size(Y));
            Z = reshape(ellipsoid(3,:), size(Z));
            h = surf(X, Y, Z, ...
                'FaceColor', opts.FaceColor, ...
                'EdgeColor', opts.EdgeColor, ...
                'FaceAlpha', opts.Alpha, ...
                'EdgeAlpha', opts.EdgeAlpha);
            lighting gouraud;
            camlight headlight;
        else
            error('Only 2D and 3D ellipsoids are supported.');
        end
    
        % Make it pretty
        axis equal;
        grid on;
        box on;
        xlabel('x'); ylabel('y'); if n == 3, zlabel('z'); end
    
        if nargout == 0
            clear h
        end
    end

    end
end
