function result = armijoNewton(point, stepSize, decentDirectionNewton, gradient)
    c = 0.0001;
    result = rosenbrock(point + stepSize*decentDirectionNewton) <= rosenbrock(point) + c * stepSize * dot(gradient, decentDirectionNewton);
end