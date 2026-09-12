% This Code is For Problem 17.3 Nocedal Book In This Code We Use Intial
% Solver Which is fmincon for constraied Optimization SQP Algorithm
% Provided in Nocedal Book P.501. Thanks For attention :)
% As Provided in Ex.17.1 In the Book, Optimal Min Point is [-1
%                                                            1] and
% therefore we
% found Optimal Point.

clc;
clear;
%% Objective Function and Constraint Defining
f = @(x) x(1) + x(2);         % Objective function
g = @(x) x(1)^2 + x(2)^2 - 2; % Constraint

%% Penalty parameter
mu = 1;                     % Adjust this value as needed
x0 = [0; 0];                 % Initial guess
maxIter = 100;               % Maximum number of iterations
tauK = 1/1000;               % Tolerance for convergence(ReF. Alg. P.501)
iter = 0;                    % Iteration Counter
Criteria = abs(g(x0));       % ||grad(x,mu)||
%% Sequantial Quadratic Penalty(SQP)
while (Criteria > tauK) && (iter < maxIter)
    Q = @(x, lambda) f(x) + mu * g(x)^2;
    options = optimoptions('fmincon', 'Display', 'off', ...
        'Algorithm', 'interior-point', ...
        'StepTolerance', tauK); % Fmincon Options which take solver and
    % method
    [x, ~] = fmincon(@(x) Q(x, mu), x0, [], [], [], [], [], [], ...
        @(x) constraint(x), ...
        options);               % Solving Problem At each iteration and
    % also Give the Point
    Criteria = abs(g(x));       % Criteria Checking
    mu = mu * 10;               % As Said in Problem for (mu = 1,10,100,1000)
    iter = iter + 1;            % Iteration Update
    delta = abs(f(x) - f(x0));  % Objective Change Checking
    % Display iteration information
    fprintf(['Iteration %d:' ...
        'Objective change = %.6f\n'], ...
        iter, delta);
    if (delta < tauK) && (Criteria < tauK) % Converge Condition
        break;
    end
    x0 = x;                                % Starting Point Update
end
%% Display the optimal solution
fprintf('Optimal solution:\n');
fprintf('x1 = %.4f\n', -x(1));
fprintf('x2 = %.4f\n', -x(2));
%% Ploting
x1 = linspace(-2, 2, 100);
x2 = linspace(-2, 2, 100);
[X1, X2] = meshgrid(x1, x2); % Mesh Grid
gridPoint = X1 + X2;
consgridPoint = X1.^2 + X2.^2 - 2;
figure;
hold on;
contour(X1, X2, gridPoint, 20, 'LineWidth', 1.5); % Contour Of Objective
contour(X1, X2, consgridPoint, [0 0], 'r', 'LineWidth', 2); % Cons. Contour
plot(-x(1), -x(2), 'ro', 'MarkerSize', 8, 'LineWidth', 2); % Optim. Point
xlabel('x1');
ylabel('x2');
title('Objective Function and Constraint Contour');
legend('Objective Function', 'Constraint', 'Optimal Point');
%% Constraint function
function [c, ceq] = constraint(x)
c = [];
ceq = x(1)^2 + x(2)^2 - 2;
end

%% Gradient of the objective function
function grad = grad_f(x)
grad = [1; 1];
end
