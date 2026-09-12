# Numerical Optimization: Golden Section & Fibonacci Methods

A MATLAB implementation of two one-dimensional minimization algorithms:

- Golden Section search
- Fibonacci search

The demonstration objective function is:

\[
f(x) = x^4 - 14x^3 + 60x^2 - 70x
\]

By default, the search interval is \([0, 2]\).

## Features

- Interactive selection between Golden Section and Fibonacci methods.
- Prints the search interval at each iteration.
- Returns the final uncertainty interval and an objective value estimate.
- No additional MATLAB toolboxes required.

## Repository Structure

```text
.
├── main.m
├── Optimization_Function.m
└── README.md
```

## Requirements

- MATLAB R2016b or newer.
- No special toolbox required.

## Usage

1. Clone the repository:

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git
cd YOUR-REPO
```

2. Open MATLAB and set the current folder to the repository folder.

3. Run:

```matlab
main
```

4. When prompted, enter:

- `1` for Golden Section optimization
- `2` for Fibonacci optimization

```text
enter "1" if you want Gss optimization and enter "2" if you want fibonacci optimization):
```

## Configuration

Edit the parameters in `main.m`:

```matlab
start_interval = 0;
end_interval = 2;
epsilon = 0.3;
accuracy = 0.1;
```

Then run `main` again.

## Outputs

`Optimization_Function` returns:

```matlab
[start_interval_opt, end_interval_opt, output_opt] = Optimization_Function(...)
```

- `start_interval_opt` — final left/lower interval bound
- `end_interval_opt` — final right/upper interval bound
- `output_opt` — average objective value over the final interval

During execution, the iteration number and current interval bounds are printed to the MATLAB Command Window.

## Algorithms

- **Golden Section**: reduces the interval using the golden ratio factor `0.382`.
- **Fibonacci**: builds a Fibonacci sequence until the stopping criterion is met and reduces the interval using Fibonacci ratios.

This project is intended for educational and numerical-methods demonstration purposes.

## Author

Fatemeh Soleymanpour

## License

MIT License. See `LICENSE` if included.
```