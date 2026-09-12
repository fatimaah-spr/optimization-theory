# Numerical Optimization: Newton and Steepest Descent Methods

A MATLAB implementation of two multi-dimensional unconstrained optimization algorithms:

- Newton's method
- Steepest Descent method

Both methods use Golden Section Search for line search (step size selection). The code supports the Rosenbrock function, the Powell function, and a quadratic test function (for Steepest Descent only).

## Repository

GitHub account: [fatimaah-spr](https://github.com/fatimaah-spr)  
Suggested repository name: `matlab-newton-steepest-descent-optimization`

## Features

- Interactive selection of test function and convergence type.
- Symbolic computation of gradient and Hessian.
- Newton's method with Hessian modification if not positive definite.
- Steepest Descent with constant step size or Golden Section line search.
- Reports final point, iteration count, function evaluations, gradient evaluations, and Hessian evaluations (Newton only).
- No additional toolboxes beyond Symbolic Math Toolbox.

## Repository Structure

```text
.
├── CA2_Newton.m
├── CA2_steepestdecent.m
└── README.md
```

## Requirements

- MATLAB R2016b or newer.
- Symbolic Math Toolbox.

## Usage

1. Clone the repository:

```bash
git clone https://github.com/fatimaah-spr/matlab-newton-steepest-descent-optimization.git
cd matlab-newton-steepest-descent-optimization
```

2. Open MATLAB and set the current folder to the repository folder.

3. Run one of the scripts:

```matlab
CA2_Newton
```

or

```matlab
CA2_steepestdecent
```

4. Follow the prompts to select the function type:

- `1` – Rosenbrock function (2D), initial point `[1; 2]`
- `2` – Powell function (4D), initial point `[1; 2; 2; 2]`
- `3` – Quadratic function (2D, only in Steepest Descent), initial point `[1; 2]`

For Steepest Descent, you will also be asked for the convergence type:

- `1` – Constant step size (`1/12`)
- `2` – Golden Section line search

## Configuration

Global parameters are defined at the top of each script:

```matlab
epsilon = 10^(-5);      % tolerance for line search
start_interval = 0;     % line search lower bound
end_interval = 4;       % line search upper bound
```

The main stopping criterion for the outer optimization loop is:

```matlab
norm(x_next - x_current) <= 10^(-3)
```

## Outputs

Both scripts print to the MATLAB Command Window:

- Final point `x_next`
- Number of outer iterations
- Number of function evaluations
- Number of gradient evaluations
- Number of Hessian evaluations (Newton only)
- Final function value

## Algorithms

- **Newton's Method**: Uses the gradient and Hessian to compute the search direction `-inv(H)*grad`. If the Hessian is not positive definite, it is modified by adding a multiple of the identity matrix. A line search is performed using Golden Section Search.
- **Steepest Descent**: Uses the negative gradient as the search direction. The step size is either a constant (`1/12`) or determined by Golden Section Search.

Both methods share a local `Gss_Function` that implements Golden Section Search over a given interval.

This project is intended for educational and numerical-methods demonstration purposes.

## Author

Fatemeh Soleymanpour  
GitHub: [fatimaah-spr](https://github.com/fatimaah-spr)