% Function that computes the gradient
function g = gradient(x)

    % Extract x1 and x2
    x1 = x(1);
    x2 = x(2);

    % Compute gradient
    g = zeros(2,1);
    g(1) = -400 * x1 * (x2 - x1^2) - 2 * (1 - x1);
    g(2) = 200 * (x2 - x1^2);

end