%% *Descreption*

% This Code Is For Optimizing Rosen Brock Function which Written According
% to Algorithm Which Provided by Nocedal In His Book On P.81 Where Both
% Zoom Algorithm and Line Search Algorithm Provided. Also Phi(alpha) Which
% Written is Just f(xk+a*p)
clc; clear; close all;
%% *Define Constant Values*

c1 = 1e-4;      % First Condition Sufficient Decrease
c2 = 0.5;       % Secound Sufficent Decrease 0<c2<0.5
d = 0.8;        % Next for Next Step Calculation
a0 = 0;         % Starting steplength is 0
a1 = 10;        % First Upper Bound
amax = 10*a1;   % amax>0 Ref.Nocedal P.81
maxiter = 100;  % Stop Condition For LS Func.
tol = 1e-3;     % Stop condition value
x0 = [1,2]';    % Starting point
%% *Define Objective Function*

syms x1 x2      % Define Varibale As Symbolic Matlab Variable
obj=@(x1,x2)100.*(x2-x1.^2).^2 + (1-x1).^2; % Cost Function To Optimize
%% *Steepest Descent Algorithm*

f0    = subs(obj,{x1,x2},x0');   % Function Eval. At x0
g     = gradient(obj,[x1,x2]);   % Gradient Of Cost Func.
g_val = subs(g,{x1,x2},x0');     % Gradient Eval. At x0
i     =1;                        % Iteration Counter  
while true
    p    = -g_val;               % Descent Direction
    a    = Linefcn(obj,p,x0,a1,a0,amax,c1,c2,d,maxiter);
    L_x0 = x0;
    x0    = double(vpa(x0+a*p));         % Calc. New Starting Point With New Direction
    f0    = subs(obj,{x1,x2},{x0'});     % Eval. Cost Funtion At New Point
    g_val = subs(g,{x1,x2},{x0'});       % Gradinet Eval. At Found Point
    if norm(x0-L_x0) < tol               % Stop Condition
        fprintf("Optimization Successfully Done at %d Iteration And Optimized x0 is: :\n",i)
        disp(x0)
        Feval =double(vpa(subs(obj,{x1,x2},{x0'})));
        fprintf("Function Evaluation At New Point is:%d\n",Feval)
        fprintf("Gradient Norm For Tolerance Critreria:%d\n",norm(x0-L_x0))
        break;
    end
Fave(i) = f0;
i=i+1;
end
dataPlot = [Fave,Feval];
plot(dataPlot,'linewidth',2)
hold on
axis([0 60 -1 27])
xlabel('Iteration')
ylabel('Function Value')
grid on

%%  *Line Search Function*

function a = Linefcn(obj,p,x0,a1,a0,amax,c1,c2,d,maxiter)
syms x1 x2
i      = 1;                                         % Iteration Index
f0     = subs(obj,{x1,x2},{x0'});                   % Objective Function Eval. at x0
gval   = gradient(obj,[x1,x2]);                     % Objective Gradient
g0     = subs(gval,{x1,x2},{x0'});                  % Objective Grad. Eval. at x0
a_0    = x0+a0*p;                                   % Phi(alpha) = f(x+alpha*p) Ref.Nocedal
f_last = subs(obj,{x1,x2},{a_0'});                  % Calc. Phi(alpha) At Starting Point
while true
    a_new = x0+a1*p;                                % New StepSize At Each Iter.
    f     = subs(obj,{x1,x2},{a_new'});             % Function Eval. With Calculated StepSize
    gval  = subs(obj,{x1,x2},{a_new'});             % Gradient Eval. With Calculated StepSize
    if (f > f0+c1*a1*g0) | ((i>1) & f > f_last)     % Checking Decrease Condtion
        a = zoomfcn(obj,x0,p,a0,a1,c1,c2);          % Local Zoom Function For Searching Best Bound
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

    if i == maxiter
        a = a1;
        return;
    end
    i      = i+1;               % For calculate the number of  iterations
    a0     = a1;                % Bound Switching By Zoom.
    a1     = d*a0+(1-d)*amax;   % a1 For Next Iter.
    f_last = f;                 % Change Last Function Value With New Val. with New a*
end
end

%% *Zoom Function*

function a_star = zoomfcn(obj,x0,p,a_low,a_up,c1,c2)

j  = 0;                                         % Iteration Calculation
syms x1 x2
f0 =  subs(obj,{x1,x2},{x0'});                  % Function Eval. At x0
g0  =  subs(obj,{x1,x2},{x0'});                 % Gradient Eval. At x0
while true
    a        = (a_low+a_up)/2;                  % Bisection InterPolation Ref.Nocedal P.81
    a_star   = x0+a*p;                          % New a Calc.
    f        = subs(obj,{x1,x2},{a_star'});     % Obj. Eval At New Point
    grad     = subs(obj,{x1,x2},{a_star'});     % Obj. Gradient Eval.
    a_last   = x0 + a_low*p;                    % Last Point Value
    if (f > f0 + c1*a*g0 || f >=subs(obj,{x1,x2},{a_last'})) % Sufficent Decraese Condition
        a_up = a;                               % [a_low,a_up]
    else
        if abs(grad) <= -c2*g0                  % Curvature Condition
            a_star  = a;                        % Strong Wolfe Condition Satisfies a* = a
            return;
        end
        if grad*(a_up-a) >= 0
            a_up  = a;
        end
        a_low = a;                              % [a,a_low]
    end
    if j == 20
        a_star = a;                             % Reach Max. Iteration Value
        return;
    end
    j = j+1;                                    % Iteration Update
end
end