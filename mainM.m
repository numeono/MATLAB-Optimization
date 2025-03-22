function m = mainM(point)
    point = point(:);

    % Declare number of iterations
    maxIterations = 1000;

    % Declare intial trust region / radius
    r = 2;
    
    % Define tolerances
    gradientNormTolerance = 10^-6;
    stepSizeTolerance = 10^-8;
    functionChangeTolerance = 10^-15;

    % Evaluate function at initial point
    f = functionM(point);

    % Initialize iteration counter
    i = 0;

    while i < maxIterations
        % Evaluate methods at point
        h = hessianM(point);
        g = gradientM(point);

        % Use dogleg method if hessian is PSD, use cauchy point only otherwise
        if psdM(h)
            step = dogLegM(g,h,r);
        else
            step = cauchyM(g,h,r);
        end

        % Now we continue with our new step size
        newPoint = point + step;

        % Logic for testing if current radius is ideal
        % Compute actual change:
        fPrevious = f;
        f = functionM(newPoint);
        fChange = fPrevious - f;

        % Now compute our quadratic model change
        zeroStep = zeros(length(point), 1); % 
        predictedChange = approximationM(zeroStep, point) - approximationM(step, point);

        % Compute ratio
        ratio = fChange / predictedChange;

        % Change radius depending on performance of quadratic model
        if ratio < 0.25
            r = r / 4;
            continue;
        elseif ratio > 0.75 && norm(step) >= 0.95 * r
            r = min(2*r, 10);
        end

        % Update point
        point = newPoint;

        % Perform tolerance checks:

        % Check norm tolerance
        gradientNorm = norm(g);
        if gradientNorm < gradientNormTolerance
            disp('Gradient tolerance reached');
            break;
        end

        % Check step size tolerance
        stepSize = norm(step);
        if stepSize < stepSizeTolerance
            disp('Step size tolerance reached');
            break;
        end       

        % Check function change tolerance
        if fChange <= functionChangeTolerance
            disp('Function change tolerance reached');
            break;
        end

        % Increment counter
        i = i + 1;
    end
    m = point;
end