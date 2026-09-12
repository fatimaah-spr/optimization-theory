# Newton's Method with Line Search (Strong Wolfe Conditions) — Powell Function

A MATLAB implementation of Newton's method for unconstrained optimization using a line search that satisfies the Strong Wolfe conditions. The line search and zoom algorithm follow Nocedal & Wright, *Numerical Optimization*, Algorithm 3.5 and 3.6 (p. 81).

The demonstration objective function is the Powell function (4D):

\[
f(x_1, x_2, x_3, x_4) = (x_1 + 10x_2)^2 + 5(x_3 - x_4)^2 + (x_2 - 2x_3)^4 + 10(x_1 - x_4)^2
\]

Initial point: `[1; 2; 2; 2]`.

## Features

- Newton's method with symbolic gradient and Hessian computation.
- Hessian modification to ensure positive definiteness.
- Line search using the Strong Wolfe conditions (sufficient decrease + curvature).
- Zoom subroutine with bisection interpolation for refining the step size.
- Reports optimized point, function value, gradient evaluations, and Hessian evaluations.
- No plotting included; results are printed to the Command Window.

## Repository Structure

```text
.
├── Powell_NT.m     # Main script: Newton's method on Powell function
└── README.md
```

The script contains two local functions:
- `Linefcn` — line search (Algorithm 3.5, Nocedal p. 81)
- `zoomfcn` — zoom subroutine (Algorithm 3.6, Nocedal p. 81)

## Requirements

- MATLAB R2016b or newer.
- Symbolic Math Toolbox.

## Usage

1. Open MATLAB and set the current folder to the repository folder.

2. Run the main script:

```matlab
Powell_NT
```

The script runs without further input and prints the results to the Command Window.

## Configuration

Parameters are defined at the top of `Powell_NT.m`:

```matlab
c1 = 1e-4;          % Sufficient decrease constant (Armijo)
c2 = 0.5;           % Curvature constant (0 < c2 < 0.5)
d  = 0.8;           % Interpolation factor for the next step length
a0 = 0;             % Initial step length
a1 = 10;            % First trial step length
amax = 10*a1;       % Maximum allowed step length
maxiter = 100;      % Max line search iterations
tol = 1e-3;         % Stopping tolerance on ||x_{k+1} - x_k||
x0 = [1, 2, 2, 2]'; % Starting point
```

## Outputs

The script prints:

- Optimized point `x*`
- Function value at the optimum
- Number of gradient evaluations
- Number of Hessian evaluations

## Algorithms

- **Newton's Method**: Computes the search direction as `p = -H^{-1} g`, where `H` is the Hessian (modified by `sqrt(eps)*I` to guarantee positive definiteness) and `g` is the gradient.
- **Line Search (Strong Wolfe)**: Finds a step size `a` such that:
  - `f(x + a p) <= f(x) + c1 * a * g^T p` (sufficient decrease)
  - `|g(x + a p)^T p| <= c2 * |g(x)^T p|` (curvature)
- **Zoom**: Refines the step size via bisection when the Wolfe conditions are not yet satisfied.

Reference: Nocedal, J., & Wright, S. (2006). *Numerical Optimization* (2nd ed.), Algorithms 3.5 and 3.6, p. 81.

This project is intended for educational and numerical-methods demonstration purposes.

## Author

Fatemeh Soleymanpour  
GitHub: [fatimaah-spr](https://github.com/fatimaah-spr)