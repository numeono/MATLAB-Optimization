function result = armijoSteep(point, stepSize, decentDirectionSteep, gradient)
    c = 0.0001;
    result = rosenbrock(point + stepSize*decentDirectionSteep) <= rosenbrock(point) + c * stepSize * dot(gradient, decentDirectionSteep);
end