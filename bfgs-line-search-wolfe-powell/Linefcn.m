function aStar = Linefcn(func,p,x0,a1)
%% Initialization Constants
c1    = 1e-4;
c2    = 0.5;
d     = 0.8;
amax  = 10*a1;
maxit = 100;
a0    = 0;
i     = 1;
%% Line Search 
syms x1 x2 x3 x4

f_first = subs(func,{x1,x2,x3,x4},{x0'});
g       = gradient(func,[x1,x2,x3,x4]);
g0      = subs(g,{x1,x2,x3,x4},{x0'});
alpha0  = x0+a0*p;     
f_last  = subs(func,{x1,x2,x3,x4},{alpha0'});
while true
    alpha = x0+a1*p;
    f     = subs(func,{x1,x2,x3,x4},{alpha'});
    g     = subs(func,{x1,x2,x3,x4},{alpha'});
    if (f > f_first+c1*a1*g0) | ((i>1) & f > f_last)
        aStar = zoomfcn(func,x0,p,a0,a1);
        return;
    end
    if abs(g) <= -c2*g0  
        aStar = a1;
        return;
    end
    if g >= 0   
        aStar = zoomfcn(func,x0,p,a1,a0);
        return;
    end    
    if i == maxit
        aStar = a1;
        return;
    end
    i      = i+1;      
    a0     = a1;    
    a1     = d*a0+(1-d)*amax;
    f_last = f;        
end
