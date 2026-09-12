function a_star = zoomfcn(obj,x0,p,a_low,a_up,c1,c2)

j  = 0;                                         % Iteration Calculation
syms x1 x2 x3 x4
f0 =  subs(obj,{x1,x2,x3,x4},{x0'});                  % Function Eval. At x0
g0  =  subs(obj,{x1,x2,x3,x4},{x0'});                 % Gradient Eval. At x0
while true
    a        = (a_low+a_up)/2;                        % Bisection InterPolation Ref.Nocedal P.81
    a_star   = x0+a*p;                          % New a Calc.
    f        = subs(obj,{x1,x2,x3,x4},{a_star'});     % Obj. Eval At New Point
    grad     = subs(obj,{x1,x2,x3,x4},{a_star'});     % Obj. Gradient Eval.
    a_last   = x0 + a_low*p;                       % Last Point Value
    f_a_last = subs(obj,{x1,x2,x3,x4},{a_last'});
    if (f > f0 + c1*a*g0 || f >= f_a_last) % Sufficent Decraese Condition
        a_up = a;                                  % [a_low,a_up]
    else
        if abs(grad) <= -c2*g0                      % Curvature Condition
            a_star  = a;                        % Strong Wolfe Condition Satisfies a* = a
            return;
        end
        if grad*(a_up-a) >= 0
            a_up  = a;
        end
        a_low = a;                                 % [a,a_low]
    end
    if j == 10
        a_star = a;                             % Reach Max. Iteration Value
        return;
    end
    j = j+1;                                    % Iteration Update
end
end