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

        function d = centerDistance(obj, other)
            % Distance between centers
            d = norm(obj.c - other.c);
        end

        function d = pointCenterDistance(obj, x)
            % Distance from point x to center
            d = norm(obj.c - x(:));
        end

        function V = volume(obj)
            % Volume of the ellipsoid
            n = length(obj.c);
            V = pi^(n/2) / gamma(n/2 + 1) * sqrt(det(inv(obj.P)));
        end

        function c = getCenter(obj)
            c = obj.c;
        end

        function n = getDims(obj)
            n = length(obj.c);
        end

        function e2 = scale(obj, alpha)
            % Scaled ellipsoid
            e2 = Ellipsoid(obj.P / alpha, obj.c * alpha);
        end
    end
end
