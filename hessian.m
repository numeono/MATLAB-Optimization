% Function that computes the Hessian
function h = hessian(x)

    % Extract x1 and x2
    x1 = x(1);
    x2 = x(2);

    % Initialize a 2x2 matrix
    h = zeros(2,2);

    % Compute Hessian matrix elements
    h(1,1) = -400 * (x2 - x1^2) + 800 * x1^2 + 2;
    h(1,2) = -400 * x1;
    h(2,1) = -400 * x1;
    h(2,2) = 200;

end