function plotOptimizationResults(iterationData)
    % Create a figure with two subplots
    figure('Name', 'Optimization Results', 'Position', [100, 100, 1000, 800]);
    
    % Plot 1: Function values vs iteration number
    subplot(2, 1, 1);
    plot(iterationData.iterations, iterationData.functionValues, 'LineWidth', 2);
    title('Function Values vs Iterations');
    xlabel('Iteration Number');
    ylabel('Function Value');
    grid on;
    
    % Plot 2: Gradient norm vs iteration number
    subplot(2, 1, 2);
    semilogy(iterationData.iterations, iterationData.gradientNorms, 'LineWidth', 2);
    title('Gradient Norm vs Iterations');
    xlabel('Iteration Number');
    ylabel('Gradient Norm (log scale)');
    grid on;
    
    % Optional: Create additional plots for step sizes
    figure('Name', 'Step Sizes', 'Position', [100, 100, 1000, 400]);
    plot(iterationData.iterations, iterationData.newtonStepSizes, 'LineWidth', 2);
    hold on;
    plot(iterationData.iterations, iterationData.steepestStepSizes, 'LineWidth', 2);
    title('Step Sizes vs Iterations');
    xlabel('Iteration Number');
    ylabel('Step Size');
    legend('Newton Method', 'Steepest Descent');
    grid on;
end