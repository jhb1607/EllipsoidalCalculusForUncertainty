function P = makeCoolCloud3D(n, type)
%MAKECOOLCLOUD3D Generate one of five cool 3D point clouds
% P = makeCoolCloud3D(n, type) returns an (n×3) cloud where
% type=1: 3D Gaussian blob centered at (-1,0,0.5)
% type=2: Two 3D intertwined rings
% type=3: 3D spiral around a sphere
% type=4: 3D ellipsoid with noise
% type=5: 3D star (stellated icosahedron)
if nargin<1||isempty(n), n=200; end
if nargin<2||isempty(type), type=1; end

switch type
    case 1 % 3D Gaussian blob
        P = 0.5*randn(n,3) + [-1, 0, 0.5];
        
    case 2 % Two intertwined rings
        m = floor(n/2);
        t = linspace(0,2*pi,m)';
        % First ring in xy-plane
        R1 = [cos(t), sin(t), zeros(size(t))]; 
        % Second ring in xz-plane, shifted
        R2 = [cos(t), zeros(size(t)), sin(t)] + [0.5, 0, 0]; 
        P = [R1; R2(1:n-m,:)] + 0.05*randn(n,3);
        
    case 3 % Spiral on a sphere
        t = linspace(0,8*pi,n)';
        r = 1;
        phi = t;
        theta = t/8;
        P = [r*sin(theta).*cos(phi), r*sin(theta).*sin(phi), r*cos(theta)];
        P = P + 0.05*randn(size(P)); % Add noise
        
    case 4 % Noisy ellipsoid
        % Generate points on a sphere
        [x,y,z] = sphere(ceil(sqrt(n)-1));
        pts = [x(:),y(:),z(:)];
        % Take n points from the sphere
        idx = randperm(numel(x), min(n, numel(x)));
        P = pts(idx,:);
        % Transform to ellipsoid
        P = P .* [1.5, 0.8, 1.2] + 0.05*randn(size(P));
        
    case 5 % 3D star (stellated shape)
        % Base icosahedron vertices
        phi = (1+sqrt(5))/2; % Golden ratio
        verts = [0,1,phi; 0,-1,phi; 0,1,-phi; 0,-1,-phi;
                1,phi,0; -1,phi,0; 1,-phi,0; -1,-phi,0;
                phi,0,1; phi,0,-1; -phi,0,1; -phi,0,-1];
        verts = verts / norm(verts(1,:)); % Normalize
        
        % Generate points
        P = zeros(n,3);
        idx = randi(size(verts,1), n, 1);
        for i = 1:n
            v = verts(idx(i),:);
            % Random distance from center (stellated effect)
            r = 0.5 + 0.5*rand();
            P(i,:) = r * v + 0.1*randn(1,3); % Add noise
        end
        
    otherwise
        error('Type must be 1–5')
end
end