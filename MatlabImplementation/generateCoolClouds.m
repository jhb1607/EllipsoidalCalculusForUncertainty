function [P1, P2, P3] = generateCoolClouds(n)
%GENERATECOOLCLOUDS Generate three “cool” 2D point clouds of size (n×2)
%   [P1,P2,P3] = generateCoolClouds(n) returns:
%     P1 — Gaussian blob
%     P2 — two interleaving “moons”
%     P3 — noisy spiral

if nargin<1 || isempty(n)
    n = 200;
end

%% 1) Gaussian blob
P1 = randn(n,2);

%% 2) Two‑moons
m = floor(n/2);
theta = linspace(0, pi, m)';
r = 1;
X1 = [ r*cos(theta),  r*sin(theta) ] + 0.05*randn(m,2);
X2 = [ r*cos(theta)+1, -r*sin(theta)-0.2 ] + 0.05*randn(m,2);
P2 = [X1; X2(1:(n-m),:)];

%% 3) Spiral
t = linspace(0, 4*pi, n)';
r = t/(4*pi);
P3 = [ r.*cos(t), r.*sin(t) ] + 0.02*randn(n,2);

end
