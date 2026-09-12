# Sequential Quadratic Penalty (SQP) for Constrained Optimization — Problem 17.3 (Nocedal)

A MATLAB implementation of a penalty method for constrained optimization, using `fmincon` as the inner solver. This code solves Problem 17.3 from Nocedal & Wright, *Numerical Optimization*, where the goal is to minimize a linear objective subject to a quadratic equality constraint. The inner solver uses an SQP (Sequential Quadratic Programming) algorithm as described in the book (p. 501).

The optimization problem is:

\[
\min_{x} \quad f(x) = x_1 + x_2
\]
\[
\text{subject to} \quad g(x) = x_1^2 + x_2^2 - 2 = 0
\]

The optimal solution is known to be \([-1; 1]\).

## Features

- Penalty method with increasing penalty parameter `mu = 1, 10, 100, 1000`.
- Inner solver: `fmincon` with interior-point algorithm.
- Convergence based on constraint violation and objective change.
- Contour plot of the objective function and constraint, with the optimal point marked.
- Reports the optimal solution.

## Repository Structure

```text
.
├── Task5.m     # Main script: SQP penalty method on Problem 17.3
└── README.md
```

## Requirements

- MATLAB R2016b or newer.
- Optimization Toolbox (for `fmincon`).

## Usage

1. Open MATLAB and set the current folder to the repository folder.

2. Run the main script:

```matlab
Task5
```

The script runs without further input and prints the results to the Command Window, then displays a contour plot.

## Configuration

Parameters are defined at the top of `Task5.m`:

```matlab
mu = 1;             % Initial penalty parameter
x0 = [0; 0];        % Initial guess
maxIter = 100;      % Maximum number of iterations
tauK = 1/1000;      % Tolerance for convergence
```

## Outputs

The script prints:

- Iteration number and objective change at each iteration.
- Optimal solution `x1` and `x2` (displayed as `-x(1)` and `-x(2)` due to the sign convention in the code).

It also plots the objective function contours, the constraint contour, and the optimal point.

## Algorithms

- **Penalty Method**: Converts the constrained problem into a sequence of unconstrained problems:
  \[
  Q(x, \mu) = f(x) + \mu \, g(x)^2
  \]
  The penalty parameter `mu` is increased (×10) each iteration until convergence.
- **Inner Solver**: `fmincon` with the interior-point algorithm, using a step tolerance of `tauK`.
- **Convergence**: Stops when both the constraint violation `|g(x)|` and the objective change `|f(x) - f(x_old)|` are below `tauK`.

Reference: Nocedal, J., & Wright, S. (2006). *Numerical Optimization* (2nd ed.), Problem 17.3 and Algorithm 17.1 (p. 501).

This project is intended for educational and numerical-methods demonstration purposes.

## Author

Fatemeh Soleymanpour  
GitHub: [fatimaah-spr](https://github.com/fatimaah-spr)