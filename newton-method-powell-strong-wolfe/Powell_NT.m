% This is Code For Rosen Brock Function Optimization This Code Is Contain 2
% Local Function Which are Line Search and Zoom Function Which Provide By
% Nocedal P.81
clc; clear; close all

c1 = 1e-4;          % First Condition Sufficient Decrease
c2 = 0.5;           % Secound Sufficent Decrease 0<c2<0.5
d = 0.8;            % Next for Next Step Calculation
a0 = 0;             % Starting steplength is 0
a1 = 10;            % First Upper Bound
amax = 10*a1;       % amax>0 Ref.Nocedal P.81
maxiter = 100;      % Stop Condition For LS Func.
tol = 1e-3;         % Stop condition value
x0 = [1,2,2,2]';    % Starting point


syms x1 x2 x3 x4

Obj = @(x1,x2,x3,x4)(x1+10.*x2).^2 + 5.*(x3-x4).^2 + (x2-2.*x3).^4 + 10.*(x1-x4).^2 ;

i=0;
geval=0;                % gradient evaluation
heval=0;                % hessian evaluation
while true 
    g = gradient(Obj,[x1,x2,x3,x4]) ;       % Gradient of function
    geval=geval+1;
    gval=double(vpa(subs(g,{x1,x2,x3,x4}',{x0})));        % Gradient value at point x0    
    H = hessian(Obj,[x1,x2,x3,x4]) ;        % Hessian of function
    heval = heval+1;
    Hval = double(vpa(subs(H,{x1,x2,x3,x4}',{x0})));      % Hessien value at point x0
    Hval = Hval+sqrt(eps)*(eye(size(Hval)));     	  % product sqrt(eps) as lowest eigen value in order to make hessian matrix positive definit
    p = -Hval\gval;     % Descent Direction 
    a = Linefcn(Obj,p,x0,a1,c1,c2,d,a0,amax,maxiter);  % Line Search function to find suitable alpha
    L_x0=x0;        % Save last x0 that calculate in order to use in in stop condition
    x0=x0+a*p;      % Calculate x0 with new a
    if norm(x0 - L_x0)<tol  % Stopping Condition
        fprintf("The optimized point at %d iteration is:\n\n",i);       
        disp(x0)
        fprintf("The function value at optimized point is:\n\n")
        f_val = double(vpa(subs(Obj,{x1,x2,x3,x4},{x0'})));
        disp(f_val)
        fprintf("%d Gradient evaluation,%d Hessian evaluation\n\n",geval,heval)
        break;
    end    
    i=i+1; % Iteration 
end
function a = Linefcn(Obj,p,x0,a1,c1,c2,d,a0,amax,maxit)
%% Line Search Codes
syms x1 x2 x3 x4        % Matlab Symbolic Func. Defining
i=1;                    % for number of iteration 

f0=subs(Obj,{x1,x2,x3,x4},{x0'});   
grad = gradient(Obj,[x1,x2,x3,x4]); 
g0=subs(grad,{x1,x2,x3,x4},{x0'});

alpha0=x0+a0*p;     % Arg f(x+alpha*p)
f_last = subs(Obj,{x1,x2,x3,x4},{alpha0'});    

while true
    alpha = x0+a1*p;
    f_new = subs(Obj,{x1,x2,x3,x4},{alpha'});   
    grad = subs(Obj,{x1,x2,x3,x4},{alpha'});
    if (f_new > f0+c1*a1*g0) | ((i>1) & f_new > f_last)  
        a = zoomfcn(Obj,x0,p,a0,a1,c1,c2,maxit);  
        return;
    end
    if abs(grad) <= -c2*g0  
        a = a1;  % a=a* strong wolfe is satisfied
        return;
    end
    if grad >= 0   
        a = zoomfcn(Obj,x0,p,a1,a0,c1,c2,maxit); 
        return;
    end
    
    if i == maxit
        a = a1;
        return;
    end

    i=i+1;      
    a0 = a1;    
    a1 = d*a0+(1-d)*amax;   
    f_last = f_new;   
end
end

function alpha = zoomfcn(Obj,x0,p,al,b,c1,c2,maxit)
%% Zoom function 

syms x1 x2 x3 x4

f0 = subs(Obj,{x1,x2,x3,x4},{x0'});      
g0 = subs(Obj,{x1,x2,x3,x4},{x0'});      
j = 0;                                  % iteration calculation
while true
    a       = (al+b)/2;
    alpha   = x0+a*p;
    f       = subs(Obj,{x1,x2,x3,x4},{alpha'});
    grad    = subs(Obj,{x1,x2,x3,x4},{alpha'});
    alpha_c = x0+al*p ;
    if (f > f0 + c1*a*g0 || f >=subs(Obj,{x1,x2,x3,x4},{alpha_c'}) ) 
        b = a;
    else
        if abs(grad) <= -c2*g0  
            alpha = a;       % a=a* Wolfe Condition
            return;
        end
        if grad*(b-a) >= 0
            b = a;
        end
        al = a;
    end
    if j==maxit 
        alpha = a;           

        return;
    end
    
    j = j+1;
end
end

