function backTrackSearch(point)
    % convert point into a column vector
    point = point(:);

    iterations = 10^6;
    stepSize = 1;
    finalK = 1;
    reductionFactor = 0.5;

    % initialize variables used in both loops
    gradientNorm = 0;
    newtonStepSize = stepSize;
    steepestStepSize = stepSize;

    for k=1:1:iterations
        gradient = gradientM(point);
        hessian = hessianM(point);
        inverseHessian = inv(hessian);

        decentDirectionSteep = (-1)* gradient;
        decentDirectionNewton = (-1) * inverseHessian * gradient;

        % backtracking algorithm for steepest decent method
        backtrackSteepest = armijoSteep(point, stepSize, decentDirectionSteep, gradient);
        while ~backtrackSteepest
            stepSize = reductionFactor * stepSize;
            steepestStepSize = stepSize;
            backtrackSteepest = armijoSteep(point, stepSize, decentDirectionSteep, gradient);
        end

        % reset step size
        stepSize = 1;

        % backtracking algorithm for Newtons method
        backtrackNewton = armijoNewton(point, stepSize, decentDirectionNewton, gradient);
        while ~backtrackNewton
            stepSize = reductionFactor * stepSize;
            newtonStepSize = stepSize;
            backtrackNewton = armijoNewton(point, stepSize, decentDirectionNewton, gradient);
        end

        steepNext = point + steepestStepSize * decentDirectionSteep;
        newtonNext = point + newtonStepSize * decentDirectionNewton;

        % make the lower function value be our new point
        if rosenbrock(steepNext) < rosenbrock(newtonNext)
            point = steepNext;
        else
            point = newtonNext;
        end

        % print the results of current iteration
        fprintf("Newton step size at k = %d: %f\n", k, newtonStepSize);
        fprintf("Steepest decent step size at k = %d: %f\n", k, steepestStepSize);

        % store norm of gradient
        gradientNorm = norm(gradient);

        % check for convergence. if converges, we stop
        if norm(gradient) < 10^(-6)
            finalK = k;
            break;
        end

        % if convergence is not satisfied and k=iterations, we terminate
        if k == iterations
            fprintf("Reached maximum number of iterations without satisfying convergence requirements\n");
        end
    end

    % compute function value at solution
    evaluatedAtSolution = rosenbrock(point);

    % print results
    fprintf("Final iteration at k = %d at the point [%f, %f]\n", finalK, point(1), point(2));
    fprintf("Function value at [%f, %f]: rosenbrock([%f, %f]) = %f\n", point(1), point(2), point(1), point(2), evaluatedAtSolution);
    fprintf("Gradient norm: %f\n", gradientNorm);
end