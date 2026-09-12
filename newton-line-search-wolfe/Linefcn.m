function a = Linefcn(obj,p,x0,a1,a0,amax,c1,c2,d,maxiter)
syms x1 x2 x3 x4
i      = 1;                                         % Iteration Index
f0     = subs(obj,{x1,x2,x3,x4},{x0'});                   % Objective Function Eval. at x0
gval   = gradient(obj,[x1,x2,x3,x4]);                     % Objective Gradient
g0     = subs(gval,{x1,x2,x3,x4},{x0'});                  % Objective Grad. Eval. at x0
a_0    = x0+a0*p;                                   % Phi(alpha) = f(x+alpha*p) Ref.Nocedal
f_last = subs(obj,{x1,x2,x3,x4},{a_0'});                  % Calc. Phi(alpha) At Starting Point
while true
    a_new = x0+a1*p;                                % New StepSize At Each Iter.
    f     = subs(obj,{x1,x2,x3,x4},{a_new'});             % Function Eval. With Calculated StepSize
    gval  = subs(obj,{x1,x2,x3,x4},{a_new'});             % Gradient Eval. With Calculated StepSize
    if (f > f0+c1*a1*g0) | ((i>1) & f > f_last)     % Checking Decrease Condtion
        a = zoomfcn(obj,x0,p,a0,a1,c1,c2);  % Local Zoom Function For Searching Best Bound
        return;
    end
    if abs(gval) <= -c2*g0
        a = a1;                                     % Strong Wolfe Satisfied Where a=a*
        return;
    end
    if gval >= 0
        a = zoomfcn(obj,x0,p,a1,a0,c1,c2);
        return;
    end

    if i == 50
        a = a1;
        return;
    end
    i      = i+1;               % For calculate the number of  iterations
    a0     = a1;                % Bound Switching By Zoom.
    a1     = d*a0+(1-d)*amax;   % a1 For Next Iter.
    f_last = f;                 % Change Last Function Value With New Val. with New a*
end
end