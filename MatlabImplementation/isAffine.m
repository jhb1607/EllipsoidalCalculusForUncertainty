function isAffine = isAffine(f, dim)
% Affine Mappings preserve lines and ratios (not distances or angles) 
    % Generate two random points and a scalar alpha
    X1 = rand(dim, 1);
    X2 = rand(dim, 1);
    alpha = rand();  % scalar in (0,1)
    
    % Compute convex combination
    X_combo = alpha * X1 + (1 - alpha) * X2;

    % Evaluate f
    f_combo = f(X_combo);
    f_expected = alpha * f(X1) + (1 - alpha) * f(X2);

    % Compare with tolerance
    isAffine = norm(f_combo - f_expected) < 1e-6;
end
