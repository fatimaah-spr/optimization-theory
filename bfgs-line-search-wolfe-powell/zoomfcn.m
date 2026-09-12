function alpha = zoomfcn(func,x0,p,a_lo,a_up)
%% Constants
c1 = 1e-4;
c2 = 0.5;
maxiter = 20;

%% Zoom 

syms x1 x2 x3 x4

f0 = subs(func,{x1,x2,x3,x4},{x0'});
g0 = subs(func,{x1,x2,x3,x4},{x0'});
j  = 0;                            
while true
    a     = (a_lo+a_up)/2;                     
    alpha = x0+a*p;
    f     = subs(func,{x1,x2,x3,x4},{alpha'});
    g  = subs(func,{x1,x2,x3,x4},{alpha'});
    alast = x0+a_lo*p ;   
    if (f > f0 + c1*a*g0 || f >=subs(func,{x1,x2,x3,x4},{alast'}) )
        a_up = a;      
    else
        if abs(g) <= -c2*g0  
            alpha = a;       
            return;
        end
        if g*(a_up-a) >= 0
            a_up = a;
        end
        a_lo = a;             
    end
    if j == maxiter       
        alpha = a;          
        return;
    end    
    j = j+1;
end


