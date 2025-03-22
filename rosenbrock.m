% Main code to compute rosenbrock function
function f = rosenbrock(x)
    
    % Extract x1 and x2
    x1 = x(1);
    x2 = x(2);
    
    % Compute function value
    f = 100 * (x2 - x1^2)^2 + (1 - x1)^2;

end