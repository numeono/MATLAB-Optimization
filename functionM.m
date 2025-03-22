% Compute function value at point
function f = functionM(point)
    
    % Extract x1 and x2
    x1 = point(1);
    x2 = point(2);
    
    % Compute function value
    f = 10 * (x2 - x1^2)^2 + (1 - x1)^2;

end