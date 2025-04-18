function [t1, t2, t3] = benchmarkEllipseFit(P, epsilon)
%BENCHMARKEllipseFit Measure computation time of MinVolEllipse vs. fitEllipseMoments
%   [tMVE, tMom] = benchmarkEllipseFit(P, epsilon)
%   P       — N×2 data points
%   epsilon — tolerance for MinVolEllipse (default: 0.01)
%
%   tMVE  — elapsed time for MinVolEllipse
%   tMom  — elapsed time for fitEllipseMoments

    if nargin < 2 || isempty(epsilon)
        epsilon = 0.01;
    end

    % Time MinVolEllipse
    tic;
    [B, y] = MinVolEllipse(P, epsilon);
    t1 = toc;

    % Time fitEllipseMoments
    tic;
    [A, c] = fitEllipseMoments(P);
    t2 = toc;

    tic;
    [C, z] = fitEllipsoidMomentsND(P, 0.99);
    t3 = toc;


    % Display results
    fprintf('MinVolEllipse:         %.6f seconds\n', t1);
    fprintf('fitEllipseMoments:     %.6f seconds\n', t2);
    fprintf('fitEllipseMomentsND:     %.6f seconds\n', t3);
end
