function alp = zoomfcn(Obj,x0,p,al,b)
%% ZOOMFCN *Zoom Function* 
% *for Further Description File _( " RosenBrock.m")_ & (_"Powell.m"_)* 
% *From Newton Alg. Are fully commented  
syms x1 x2 x3 x4
c1    = 1e-4;
c2    = 0.5;
f0    =subs(Obj,{x1,x2,x3,x4},{x0'});      
g0    =subs(Obj,{x1,x2,x3,x4},{x0'});      
j     = 0; 
while true
    a         = (al+b)/2;                          
    alp       = x0+a*p;
    f         = subs(Obj,{x1,x2,x3,x4},{alp'});
    g         = subs(Obj,{x1,x2,x3,x4},{alp'});
    a_before  = x0+al*p ;    
    if (f > f0 + c1*a*g0 || f >=subs(Obj,{x1,x2,x3,x4},{a_before'}) ) 
        b = a;      
    else
        if abs(g) <= -c2*g0  % curvature condition
            alp = a;       % a=a* that satisfies the strong wolfe condition 
            return;
        end
        if g*(b-a) >= 0
            b = a;
        end
        al = a;             % the interval is now [a,al]
    end        
    if j==20        
        alp = a;           % choose when we reach the maximum iteration
        return;
    end    
    j = j+1;
end