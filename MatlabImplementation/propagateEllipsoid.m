%% Simple Propagation: 
% Sample Ellipsoid boundary and just apply f(x) on each sample

function [P_new, c_new] = propagateEllipsoid(P, c, f, N, in)
    % Sample points on the ellipsoid's boundary
    if in == 0
        samples = sampleEllipsoidBoundary(P, c, N);
    else 
        samples = sampleEllipsoidInterior(P, c, N);
    end

    % Create a figure with subplots
    figure;
    sgtitle(['Propagation with function $f: ', func2str(f), '$'], 'Interpreter', 'latex');

    % First subplot: plot the samples
    subplot(2, 2, 1);
    plotCoolCloud(samples); 
    title('Original Samples');
    axis equal;
    grid on;
    hold off;

    % Second subplot: plot the original ellipsoid  
    subplot(2, 2, 2);
    hold on;
    Ellipsoid(P, c).plot('Color', [0.2 0.6 0.8], 'EdgeColor', 'k');
    title('Original Ellipsoid');
    axis equal;
    grid on;

    % Propagate the samples through the function f
    propagated_samples = f(samples)

    % Third subplot: plot the propagated samples vs old samples
    subplot(2, 2, 3);
    plotCoolCloud(samples, propagated_samples);
    title('Propagated Samples vs Old Samples');
    axis equal;
    grid on;

    % Fourth subplot: plot the propagated_samples
    % and the new ellipsoid resulting from MVEE 
    [P_new, c_new] = MinVolEllipse(propagated_samples, 0.01);

    subplot(2, 2, 4);
    hold on;
    Ellipsoid(P_new, c_new).plot('Color', [0.8 0.2 0.2], 'EdgeColor', 'k', 'Alpha', 0.7); 
    Ellipsoid(P, c).plot('Color', [0.2 0.6 0.8], 'EdgeColor', 'k', 'Alpha', 0.5);
    title('New MVEE vs Old Ellipsoid');
    axis equal;
    grid on;
    
end
