%% Example: Propagation of Ellipsoid Samples
% This script demonstrates ellipsoid (boundary) sampling and 
% function propagation with various transformations.

% Define Ellipsoids
P1 = [1, -0.4; -0.4, 0.25];
c1 = [2; -1];
E1 = Ellipsoid(P1, c1);

P2 = [0.25, 0; 0, 1];
c2 = [1; 1];
E2 = Ellipsoid(P2, c2);

N = 1000;  % number of samples

%% f(x) = 2x
f1 = @(X) 2 * X;
[M1, d1] = propagateEllipsoid(P1, c1, f1, N, 0);
newE1 = Ellipsoid(M1, d1);
fprintf('\nVolume of E1 : %.3f\n', E1.volume());
fprintf('Volume of new MVEE : %.3f\n', newE1.volume);
fprintf('Volume ratio : %.3f\n', newE1.volume / E1.volume());

fprintf('\nDistance measurements:\n');
fprintf('Center distance between E1 and new MVEE : %.3f\n', E1.centerDistance(newE1));

%% f(x) = x / 2
f2 = @(X) 0.5 * X;
[M1, d1] = propagateEllipsoid(P1, c1, f2, N, 0);
newE1 = Ellipsoid(M1, d1);
fprintf('\nVolume of E1 : %.3f\n', E1.volume());
fprintf('Volume of new MVEE : %.3f\n', newE1.volume);
fprintf('Volume ratio : %.3f\n', newE1.volume / E1.volume());

fprintf('\nDistance measurements:\n');
fprintf('Center distance between E1 and new MVEE : %.3f\n', E1.centerDistance(newE1));

%% f(x) = x^2
f3 = @(X) sin(X);
[M1, d1] = propagateEllipsoid(P1, c1, f3, N, 1);
newE1 = Ellipsoid(M1, d1);
fprintf('\nVolume of E1 : %.3f\n', E1.volume());
fprintf('Volume of new MVEE : %.3f\n', newE1.volume);
fprintf('Volume ratio : %.3f\n', newE1.volume / E1.volume());

fprintf('\nDistance measurements:\n');
fprintf('Center distance between E1 and new MVEE : %.3f\n', E1.centerDistance(newE1));

%%
% Sample ellipsoid points
samples_E1 = sampleEllipsoidInterior(P1, c1, N);
samples_E2 = sampleEllipsoidInterior(P2, c2, N);
E1.plot('Color', [0.8 0.2 0.2], 'EdgeColor', 'k', 'Alpha', 0.7)
hold on;
E2.plot('Color', [0.5 0.2 1], 'EdgeColor', 'k', 'Alpha', 0.7)

%% Minkowski sum of ellipsoid samples does not yield new Ellipsoid
% Minkowski sum of ellipsoid samples demonstrates sufficiency of boundary sampling
[M_sum, c_sum] = minkowskiEllipsoidPropagation(P1, c1, P2, c2, 2000, 'sum', 0);      % E1 + E2
[M_diff1, c_diff1] = minkowskiEllipsoidPropagation(P1, c1, P2, c2, 2000, 'diff', 0); % E1 - E2
[M_diff2, c_diff2] = minkowskiEllipsoidPropagation(P2, c2, P1, c1, 2000, 'diff', 0); % E2 - E1

%% Linear Transformation 
A = [0]

