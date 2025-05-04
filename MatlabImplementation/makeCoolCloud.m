function P = makeCoolCloud(n, type)
%GENERATECOOLCLOUD Generate one of five cool 2D point clouds
%   P = generateCoolCloud(n, type) returns an (n×2) cloud where
%     type=1: Gaussian blob centered at (-1,0)
%     type=2: Two moons
%     type=3: Noisy spiral centered at (1,1)
%     type=4: Noisy ellipse
%     type=5: Star shape with noise

if nargin<1||isempty(n), n=200; end
if nargin<2||isempty(type), type=1; end

switch type
    case 1  % Gaussian blob at (-0.5,0)
        P = 0.5*randn(n,2) + [-1, 0];

    case 2  % Two moons
        m = floor(n/2);
        t = linspace(0,pi,m)';
        A = [cos(t), sin(t)]; B = [cos(t)+1, -sin(t)-0.2];
        P = [A; B(1:n-m,:)] + 0.05*randn(n,2);

    case 3  % Spiral centered at (1,1)
        t = linspace(0,4*pi,n)'; r = t/(4*pi);
        P = [r.*cos(t), r.*sin(t)] + repmat([1,1], n, 1);

    case 4  % Noisy ellipse
        t = linspace(0, 2*pi, n)';
        a = 1; b = 0.5;  
        r = (a * b) ./ sqrt((b*cos(t)).^2 + (a*sin(t)).^2);
        noise = 0.05 * randn(n,1);
        P = [ (r+noise).*cos(t), (r+noise).*sin(t) ];

    case 5  % Star 
        theta = linspace(0,2*pi,n)';
        R = 1 + 0.3*sin(5*theta);  
        P = [R.*cos(theta), R.*sin(theta)];

    otherwise
        error('Type must be 1–5')
end
end

