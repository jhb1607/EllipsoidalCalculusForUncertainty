function [A, c] = fitEllipseMoments(points)
    % points: N×2 array of [x, y]
    x = points(:,1);
    y = points(:,2);
    N = size(points,1);

    m10 = sum(x);   
    m01 = sum(y);
    m20 = sum(x.^2); 
    m02 = sum(y.^2);
    m11 = sum(x.*y);

    xc = m10/N;
    yc = m01/N;

    a = m20/N - xc^2;
    b = 2*(m11/N - xc*yc);
    c0 = m02/N - yc^2;

    theta = 0.5 * atan2(b, a - c0);
    Delta = sqrt(b^2 + (a - c0)^2);

    l = sqrt(3*(a + c0 + Delta));  % semi‑major
    w = sqrt(3*(a + c0 - Delta));  % semi‑minor

    R = [cos(theta), -sin(theta);
         sin(theta),  cos(theta)];
    D = diag([1/l^2, 1/w^2]);

    A = R * D * R';
    c = [xc; yc];
end
