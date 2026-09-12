function a = Linefcn(func,p,x0,a1)
%% initialization
c1 = 1e-4;        % sufficient decrease
c2 = 0.5;         % secound condition sufficient decrease
rho = 0.8;          % Next Step
amax = 10*a1;     % amax>0 Ref.Nocedal
maxiter = 100;    % Stoping Iteration
%% Line Search Codes
syms x1 x2
a0     = 0;                          % Startimg Step Lenght
i      =1;                           % for number of iteration
f0     = subs(func,{x1,x2},{x0'});   % Function Calculation at x0
g      = gradient(func,[x1,x2]);
g0_val = subs(g,{x1,x2},{x0'});
alpha0  =x0+a0*p;                       % Phi(alpha) Ref. Nocedal
f_start = subs(func,{x1,x2},{alpha0'}); % Func. Calc. at First Point
while true
    alpha = x0+a1*p;
    f     = subs(func,{x1,x2},{alpha'});    % Func. Eval at x0
    g     = subs(func,{x1,x2},{alpha'});    % Gradient. Eval at x0
    if (f > f0+c1*a1*g0_val) | ((i>1) & f > f_start)  % sufficient decrease
        a = zoomfcn(func,x0,p,a0,a1);   % Bound Search
        return;
    end
    if abs(g) <= -c2*g0_val
        a = a1;  % Strong Wolfe satisfaction Part.
        return;
    end
    if g >= 0
        a = zoomfcn(func,x0,p,a1,a0); % Zoom at [a1,a0]
        return;
    end
    if i == maxiter
        a = a1;
        return;
    end
    i       =i+1;                    % Iteration Counter
    a0      = a1;                    % Bound Preallocated
    a1      = rho*a0+(1-rho)*amax;   % Calc. Next Bound
    f_start = f;                     % Save Last Func. Calc.
end
