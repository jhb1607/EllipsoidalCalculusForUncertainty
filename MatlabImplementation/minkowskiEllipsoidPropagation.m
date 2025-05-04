function [P_out, c_out] = minkowskiEllipsoidPropagation(P1, c1, P2, c2, N, operation, in)
    if nargin < 7, in = 1; end  % Default: interior
    if nargin < 6, operation = 'sum'; end  % Default operation

    % Sample points from interior or boundary
    if in == 0
        samples1 = sampleEllipsoidBoundary(P1, c1, N);
        samples2 = sampleEllipsoidBoundary(P2, c2, N);
    else
        samples1 = sampleEllipsoidInterior(P1, c1, N);
        samples2 = sampleEllipsoidInterior(P2, c2, N);
    end

    % Combine samples: sum or difference
    switch lower(operation)
        case 'sum'
            combined = samples1 + samples2;
        case 'diff'
            combined = samples1 - samples2;
        otherwise
            error('Unsupported operation. Use "sum" or "diff".');
    end

    % Fit MVEE to combined samples
    [P_out, c_out] = MinVolEllipse(combined, 0.01);

    % Optional: plot all
    figure;
    sgtitle(['Minkowski ', operation, ' of Ellipsoids'], 'Interpreter', 'latex');

    subplot(2, 2, 1); hold on;
    plotCoolCloud(samples1, samples2);
    title('samples 1 and 2'); axis equal; grid on;

    subplot(2, 2, 2); hold on;
    Ellipsoid(P1, c1).plot('Color', [0.2 0.6 0.8], 'EdgeColor', 'k');
    Ellipsoid(P2, c2).plot('Color', [0.8 0.6 0.2], 'EdgeColor', 'k'); 
    title('Ellipsoid 1 and 2'); axis equal; grid on;

    subplot(2, 2, 3); hold on;
    plotCoolCloud(samples1, samples2, combined);
    title('samples 1, 2 and Minkowski samples'); axis equal; grid on;

    subplot(2, 2, 4); hold on;
    Ellipsoid(P1, c1).plot('Color', [0.2 0.6 0.8], 'EdgeColor', 'k');
    Ellipsoid(P2, c2).plot('Color', [0.8 0.6 0.2], 'EdgeColor', 'k'); 
    Ellipsoid(P_out, c_out).plot('Color', [0.5 0.1 1], 'EdgeColor', 'k')
    title('Ellipsoid 1,2 and MVEE of Minkowski Result'); axis equal; grid on;

end
