% ellipsoid_examples.m - Demonstrate features of the Ellipsoid class
clc; close all; 
%% Create some 2D ellipsoids
E1 = Ellipsoid([1 -.4; -.4 1/4], [2; -1]);
E2 = Ellipsoid([1/4 0; 0 1], [1; 1]);
E3 = E1 * 2;             % Scalar multiplication
E4 = E2.scale(0.5);      % Explicit scaling

%% 2D Plotting example
close all;
figure('Name', '2D Ellipsoids', 'Position', [100 100 800 600]);

% Plot all ellipsoids with different styles
subplot(2,2,1);
E1.plot('Color', [0.8 0.2 0.2], 'EdgeColor', 'k');
title('Basic Ellipsoid');
xlabel('x'); ylabel('y'); axis equal;

subplot(2,2,2);
E2.plot('Color', [0.2 0.6 0.8], 'EdgeColor', 'k', 'Alpha', 0.7);
hold on;
E1.plot('Color', [0.8 0.2 0.2], 'EdgeColor', 'k', 'Alpha', 0.3);
title('Multiple Ellipsoids');
xlabel('x'); ylabel('y'); axis equal;
hold off;

subplot(2,2,3);
E1.plot('Color', [0.8 0.2 0.2], 'EdgeColor', 'k');
hold on;
E3.plot('Color', [0.2 0.8 0.2], 'EdgeColor', 'k', 'Alpha', 0.3);
title('Scaled Ellipsoid (E * 2)');
xlabel('x'); ylabel('y'); axis equal;
hold off;

subplot(2,2,4);
E2.plot('Color', [0.2 0.6 0.8], 'EdgeColor', 'k');
hold on;
E4.plot('Color', [0.8 0.6 0.2], 'EdgeColor', 'k', 'Alpha', 0.3);
title('Scaled Ellipsoid (E.scale(0.5))');
xlabel('x'); ylabel('y'); axis equal;
hold off;

%% Create some 3D ellipsoids
E5 = Ellipsoid([1/9 0 0; 0 1/4 0; 0 0 1], [0; 0; 0]);
E6 = Ellipsoid([1/2 1/4 0; 1/4 1/3 0; 0 0 1/4], [3; 2; 1]);
E7 = E5 / 2;
E8 = E6.scale(0.7);

%% 3D Plotting example
figure('Name', '3D Ellipsoids', 'Position', [100 100 800 600]);

subplot(2,2,1);
E5.plot('Color', [0.8 0.2 0.2], 'Resolution', 20);
title('Basic 3D Ellipsoid');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal;

subplot(2,2,2);
E6.plot('Color', [0.2 0.6 0.8], 'EdgeColor', [0.1 0.1 0.1], 'EdgeAlpha', 0.2);
hold on;
E5.plot('Color', [0.8 0.2 0.2], 'Alpha', 0.3);
title('Multiple 3D Ellipsoids');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal;
hold off;

subplot(2,2,3);
E5.plot('Color', [0.8 0.2 0.2]);
hold on;
E7.plot('Color', [0.2 0.8 0.2], 'Alpha', 0.3);
title('Scaled Ellipsoid (E / 2)');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal;
hold off;

subplot(2,2,4);
E6.plot('Color', [0.2 0.6 0.8]);
hold on;
E8.plot('Color', [0.8 0.6 0.2], 'Alpha', 0.3);
title('Scaled Ellipsoid (E.scale(0.7))');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal;
hold off;

%% Demonstrate other methods
fprintf('Ellipsoid operations:\n');
fprintf('Volume of E1: %.3f\n', E1.volume());
fprintf('Volume of E3 (E1*2): %.3f\n', E3.volume());
fprintf('Volume ratio should be 1/sqrt(2^-2): %.3f\n', E3.volume() / E1.volume());

fprintf('\nVolume of E5 (3D): %.3f\n', E5.volume());
fprintf('Volume of E7 (E5/2): %.3f\n', E7.volume());
fprintf('Volume ratio should be (1/sqrt(2^3)) = 0.125: %.3f\n', E7.volume() / E5.volume());

fprintf('\nDistance measurements:\n');
fprintf('Center distance between E1 and E2: %.3f\n', E1.centerDistance(E2));
fprintf('Point [3;1] to E1 center: %.3f\n', E1.pointCenterDistance([3;1]));

%% Animation example - rotating and scaling ellipsoid
figure('Name', 'Animated Ellipsoid', 'Position', [300 300 500 500]);
E = E5;

% Plot initial ellipsoid
h = E.plot('Color', [0.3 0.6 0.9], 'EdgeColor', [0.1 0.1 0.1], 'EdgeAlpha', 0.3);
title('Animated Ellipsoid');
xlabel('x'); ylabel('y'); zlabel('z');
axis([-5 5 -5 5 -5 5]); axis equal;

% Animation loop
for t = 0:0.05:2*pi
    % Create rotation matrix (rotate around z-axis)
    R = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
    
    % Rotate shape matrix
    P_rot = R * E.P * R';
    E_rot = Ellipsoid(P_rot, E.c);
    
    % Scale based on sine wave
    scale_factor = 1 + 0.3*sin(2*t);
    E_anim = E_rot * scale_factor;
    
    % Update plot
    delete(h);
    h = E_anim.plot('Color', [0.3 0.6 0.9], 'EdgeColor', [0.1 0.1 0.1], 'EdgeAlpha', 0.3);
    
    % Rotate view
    view(40 + 5*sin(t/2), 30 + 5*cos(t/2));
    
    drawnow;
    pause(0.01);
end
