# Optimization Theory

A collection of numerical optimization algorithms implemented in MATLAB.

## Repository

GitHub account: [fatimaah-spr](https://github.com/fatimaah-spr)  
Repository name: `optimization-theory`

## Projects

This repository contains the following projects, each in its own folder.

### 1. Golden Section & Fibonacci Search

Folder: `golden-section-fibonacci-search`

One-dimensional minimization using Golden Section and Fibonacci search.

Objective: \( f(x) = x^4 - 14x^3 + 60x^2 - 70x \), interval \([0, 2]\).

**Files:** `main.m`, `Optimization_Function.m`

**Usage:** Run `main`, choose `1` for Golden Section or `2` for Fibonacci.

**Outputs:** Final interval bounds and objective value estimate.

### 2. Newton & Steepest Descent (Multi-Dimensional)

Folder: `newton-steepest-descent`

Newton and Steepest Descent methods with Golden Section line search.

Supports Rosenbrock (2D), Powell (4D), and a quadratic test function (SD only).

**Files:** `CA2_Newton.m`, `CA2_steepestdecent.m`

**Usage:** Run either script and follow prompts for function and convergence type.

**Outputs:** Final point, iteration count, function/gradient/Hessian evaluations, final function value.

### 3. Newton with Line Search (Strong Wolfe) — Rosenbrock

Folder: `newton-line-search-wolfe`

Newton's method with Strong Wolfe line search (Nocedal p. 81).

Objective: Rosenbrock function, initial point `[1; 2]`.

**Files:** `RosenBrock_NT.m`, `Linefcn.m`, `zoomfcn.m`

**Usage:** Run `RosenBrock_NT`.

**Outputs:** Optimized point, function value, gradient/Hessian evaluations, iteration plot.

### 4. Newton with Line Search (Strong Wolfe) — Powell

Folder: `newton-line-search-wolfe-powell`

Newton's method with Strong Wolfe line search (Nocedal p. 81).

Objective: Powell function (4D), initial point `[1; 2; 2; 2]`.

**Files:** `Powell_NT.m`

**Usage:** Run `Powell_NT`.

**Outputs:** Optimized point, function value, gradient/Hessian evaluations.

### 5. Steepest Descent with Line Search (Strong Wolfe) — Powell

Folder: `steepest-descent-line-search-wolfe-powell`

Steepest Descent with Strong Wolfe line search (Nocedal p. 81).

Objective: Powell function (4D), initial point `[1; 2; 2; 2]`.

> **Note:** Execution may take 5–10 minutes due to symbolic 4D computations.

**Files:** `Powell_SD.m`, `linefcn.m`, `zoomfcn.m`

**Usage:** Run `Powell_SD`.

**Outputs:** Optimized point, function value, final step norm, iteration plot.

### 6. Steepest Descent with Line Search (Strong Wolfe) — Rosenbrock

Folder: `steepest-descent-line-search-wolfe-rosenbrock`

Steepest Descent with Strong Wolfe line search (Nocedal p. 81).

Objective: Rosenbrock function, initial point `[1; 2]`.

**Files:** `RosenBrock_SD.m`

**Usage:** Run `RosenBrock_SD`.

**Outputs:** Optimized point, function value, final step norm, iteration plot.

### 7. BFGS with Line Search (Strong Wolfe) — Powell

Folder: `bfgs-line-search-wolfe-powell`

BFGS quasi-Newton method with Strong Wolfe line search (Nocedal p. 81).

Objective: Powell function (4D), initial point `[1; 2; 2; 2]`.

> **Note:** Stops at iteration 9 due to long runtime.

**Files:** `BFGS_Powel.m`, `Linefcn.m`, `zoomfcn.m`

**Usage:** Run `BFGS_Powel`.

**Outputs:** Point at iteration 9, final gradient norm.

### 8. BFGS with Line Search (Strong Wolfe) — Rosenbrock

Folder: `bfgs-line-search-wolfe-rosenbrock`

BFGS quasi-Newton method with Strong Wolfe line search (Nocedal p. 81).

Objective: Rosenbrock function, initial point `[1; 2]`.

**Files:** `RosenBrock.m`, `Linefcn.m`, `zoomfcn.m`

**Usage:** Run `RosenBrock`.

**Outputs:** Optimal point, function value at optimum.

### 9. SQP Penalty Method for Constrained Optimization

Folder: `sqp-penalty-constrained-optimization`

Sequential Quadratic Penalty method using `fmincon` as inner solver.

Problem: minimize \(x_1 + x_2\) subject to \(x_1^2 + x_2^2 = 2\) (Nocedal Problem 17.3).

**Files:** `Task5.m`

**Usage:** Run `Task5`.

**Outputs:** Iteration log, optimal solution, contour plot.

## Repository Structure

```text
optimization-theory/
├── README.md
├── golden-section-fibonacci-search/
│   ├── main.m
│   └── Optimization_Function.m
├── newton-steepest-descent/
│   ├── CA2_Newton.m
│   └── CA2_steepestdecent.m
├── newton-line-search-wolfe/
│   ├── RosenBrock_NT.m
│   ├── Linefcn.m
│   └── zoomfcn.m
├── newton-line-search-wolfe-powell/
│   └── Powell_NT.m
├── steepest-descent-line-search-wolfe-powell/
│   ├── Powell_SD.m
│   ├── linefcn.m
│   └── zoomfcn.m
├── steepest-descent-line-search-wolfe-rosenbrock/
│   └── RosenBrock_SD.m
├── bfgs-line-search-wolfe-powell/
│   ├── BFGS_Powel.m
│   ├── Linefcn.m
│   └── zoomfcn.m
├── bfgs-line-search-wolfe-rosenbrock/
│   ├── RosenBrock.m
│   ├── Linefcn.m
│   └── zoomfcn.m
└── sqp-penalty-constrained-optimization/
    └── Task5.m
```

## General Requirements

- MATLAB R2016b or newer.
- Symbolic Math Toolbox (for all Newton, Steepest Descent, and BFGS projects).
- Optimization Toolbox (for the SQP penalty project).

## Author

Fatemeh Soleymanpour  
GitHub: [fatimaah-spr](https://github.com/fatimaah-spr)
