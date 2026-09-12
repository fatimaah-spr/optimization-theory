# Steepest Descent with Line Search (Strong Wolfe Conditions) — Powell Function

A MATLAB implementation of the Steepest Descent method for unconstrained optimization using a line search that satisfies the Strong Wolfe conditions. The line search and zoom algorithm follow Nocedal & Wright, *Numerical Optimization*, Algorithm 3.5 and 3.6 (p. 81).

The demonstration objective function is the Powell function (4D):

\[
f(x_1, x_2, x_3, x_4) = (x_1 + 10x_2)^2 + 5(x_3 - x_4)^2 + (x_2 - 2x_3)^4 + 10(x_1 - x_4)^2
\]

Initial point: `[1; 2; 2; 2]`.

> **Note:** Because this function has 4 variables and uses symbolic computations, execution may take around 5–10 minutes. Please wait until the result is printed.

## Features

- Steepest Descent method with symbolic gradient computation.
- Line search using the Strong Wolfe conditions (sufficient decrease + curvature).
- Zoom subroutine with bisection interpolation for refining the step size.
- Modular design: line search and zoom are separate `.m` files.
- Iteration history plotted at the end of the run.
- Reports optimized point, function value, and the final step norm.

## Repository Structure

```text
.
├── Powell_SD.m     # Main script: Steepest Descent on Powell function
├── linefcn.m       # Line search (Algorithm 3.5, Nocedal p. 81)
├── zoomfcn.m       # Zoom subroutine (Algorithm 3.6, Nocedal p. 81)
└── README.md
```

## Requirements

- MATLAB R2016b or newer.
- Symbolic Math Toolbox.

## Usage

1. Open MATLAB and set the current folder to the repository folder.

2. Run the main script:

```matlab
Powell_SD
```

The script runs without further input and prints the results to the Command Window.

## Configuration

Parameters are defined at the top of `Powell_SD.m`:

```matlab
x0 = [1, 2, 2, 2]';   % Starting point
tol = 1e-3;           % Stopping tolerance on ||x_{k+1} - x_k||
```

Line search constants are defined inside `linefcn.m` and `zoomfcn.m`:

```matlab
c1 = 1e-4;            % Sufficient decrease constant (Armijo)
c2 = 0.5;             % Curvature constant (0 < c2 < 0.5)
d  = 0.8;             % Interpolation factor for the next step length
amax = 10*a1;         % Maximum allowed step length
```

## Outputs

The script prints:

- Final iteration number
- Optimized point `x*`
- Function value at the optimum
- Final step norm `||x0 - L_x0||`

It also plots the objective value per iteration.

## Algorithms

- **Steepest Descent**: Uses the negative gradient `d = -g` as the search direction.
- **Line Search (Strong Wolfe)**: Finds a step size `a` such that:
  - `f(x + a p) <= f(x) + c1 * a * g^T p` (sufficient decrease)
  - `|g(x + a p)^T p| <= c2 * |g(x)^T p|` (curvature)
- **Zoom**: Refines the step size via bisection when the Wolfe conditions are not yet satisfied.

Reference: Nocedal, J., & Wright, S. (2006). *Numerical Optimization* (2nd ed.), Algorithms 3.5 and 3.6, p. 81.

This project is intended for educational and numerical-methods demonstration purposes.

## Author

Fatemeh Soleymanpour  
GitHub: [fatimaah-spr](https://github.com/fatimaah-spr)