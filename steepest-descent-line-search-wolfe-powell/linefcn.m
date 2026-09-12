function a = linefcn(Obj,p,x0,a1)
%% LINEFCN *Line Search Function*
% *for Further Description File ( "RosenBrock.m") & ("Powell.m")* 
% *From Newton Alg. Are fully commented*  
syms x1 x2 x3 x4              
c1      = 1e-4;
c2      = 0.5;
d       = 0.8;
amax    = 10*a1;
a0      = 0;
i       = 1;
f0      = subs(Obj,{x1,x2,x3,x4},{x0'});   
g       = gradient(Obj,[x1,x2,x3,x4]); 
g_0     = subs(g,{x1,x2,x3,x4},{x0'});
al0     = x0+a0*p;     
f_last  = subs(Obj,{x1,x2,x3,x4},{al0'});    
while true
    alp  = x0+a1*p;
    f    = subs(Obj,{x1,x2,x3,x4},{alp'});    
    g = subs(Obj,{x1,x2,x3,x4},{alp'});
    if (f > f0+c1*a1*g_0) | ((i>1) & f > f_last)  
        a = zoomfcn(Obj,x0,p,a0,a1);  
        return;
    end
    if abs(g) <= -c2*g_0  
        a = a1;  
        return;
    end
    if g >= 0   
        a = zoomfcn(Obj,x0,p,a1,a0); 
        return;
    end    
    if i == 100       
        a = a1;
        return;
    end
    i      = i+1;      
    a0     = a1;    
    a1     = d*a0+(1-d)*amax;   
    f_last = f;           
end