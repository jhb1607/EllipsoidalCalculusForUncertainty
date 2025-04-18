function [Ps, Cs, alphas] = fitEllipsoidMomentsForLevels(points)
%FITELLIPSOIDMOMENTSFORLEVELS Compute ellipsoid fits over multiple alpha-levels
%   [Ps, Cs, alphas] = fitEllipsoidMomentsForLevels(points)
%   points — N×n data matrix
%   Outputs:
%     Ps     — n×n×L array of shape matrices P for each level
%     Cs     — n×L   array of centers c for each level
%     alphas — 1×L   vector of alpha levels (0.1:0.1:1.0)
%
    [~, n] = size(points);
    alphas = 0.1:0.1:1.0;
    L = numel(alphas);

    % preallocate
    Ps = zeros(n, n, L);
    Cs = zeros(n, L);

    for i = 1:L
        alpha = alphas(i);
        [P, c] = fitEllipsoidMomentsND(points, alpha);
        Ps(:,:,i) = P;
        Cs(:,i)   = c;
    end
end
