% g = gradient, h = hessian, r = trust region,
function dogLeg = dogLegM(g,h,r)
    % Compute stuff we need
    minimizingConstant = (g' * g) / (g' * h * g);
    cauchyStep = (-1)*minimizingConstant*g;
    cauchyNorm = norm(cauchyStep);

    % We only run this method if hessian is PSD, so we use cholesky decomp
    % to find the newton step, which minimizes the approximation function

    % Decompose matrix into lower triangular
    L = chol(h, 'lower');

    % Use forward substitution
    y = L \ (-g);

    % Using back substitution
    newtonStep = L' \ y;

    % Find norm
    newtonNorm = norm(newtonStep);

    % dogLeg logic
    if cauchyNorm <= r
        dogLeg = cauchyStep;
    else
        if newtonNorm <= r
            dogLeg = newtonStep;
        else
	        tau = (r - cauchyNorm) / (newtonNorm - cauchyNorm);
            % Interpolate between cauchyStep and newtonStep to find step within trust region
            dogLeg = cauchyStep + tau * (newtonStep - cauchyStep);
        end
    end
end
