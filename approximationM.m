function mk = approximationM(p, point)
    
    % Compute function value at xk
    fk = functionM(point);
    
    % Compute gradient at xk
    gk = gradientM(point);
    
    % Compute Hessian at xk
    Bk = hessianM(point);
    
    % Force p to be a column vector
    p = p(:);

    % Compute model value
    mk = fk + gk' * p + 0.5 * p' * Bk * p;

end
