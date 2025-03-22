% g = gradient, h = hessian, r = trust region
function cauchy = cauchyM(g, h, r)
    % Compute minimizing constant for Cauchy point
    minimizingConstant = (g' * g) / (g' * h * g);
    
    % Calculate the Cauchy step (steepest descent step)
    cauchyStep = (-1)*minimizingConstant*g;
    
    % Compute norm of Cauchy step
    cauchyNorm = norm(cauchyStep);
    
    % If Cauchy step is within trust region, use it
    if cauchyNorm <= r
        cauchy = cauchyStep;
    else
        cauchy = (r / cauchyNorm) * cauchyStep;
    end
end