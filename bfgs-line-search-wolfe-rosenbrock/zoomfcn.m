function alpha = zoomfcn(func,x0,p,al,a_up)
%% Initialization
c1      = 1e-4;
c2      = 0.5;
maxiter = 20;
%% Zoom function Codes
syms x1 x2
f0     = subs(func,{x1,x2},{x0'});      % Function Eval. at point x0
g0_val = subs(func,{x1,x2},{x0'});      % Gradient Eval. at point x0
j      = 0;                             % Itaation Counter
while true
    a       = (al+a_up)/2;                    % Bisection Interpolation
    alpha   = x0+a*p;                         % New alpha Calc.
    f       = subs(func,{x1,x2},{alpha'});    % Function Eval.
    g       = subs(func,{x1,x2},{alpha'});
    alphac  = x0+al*p ;
    if (f > f0 + c1*a*g0_val || f >=subs(func,{x1,x2},{alphac'}) ) % Condition
        a_up = a;      % New Interval
    else
        if abs(g) <= -c2*g0_val  % curvature condition
            alpha = a;           % Wolfe Satisfaction
            return;
        end
        if g*(a_up-a) >= 0
            a_up = a;
        end
        al = a;             % Calc. New Bound 
    end
    if j==maxiter
        alpha = a;           % Maximum Iteration alpha
        return;
    end
    j = j+1;
end