% This is Code for Powell Function With BFGS Algorithm This Optimization
% Problem has Four Variable Which need to be Optimized So "Time" needed to
% run this code take much more than newton Algortithm so We catch Point
% Value At Iteration "9" And Use it as Observation. Also For Commenting the
% codes, For Time saving Rosen Brock is fully commented. Thanks For
% Attention:)

clc; clear;
%% Define Constants
x0 = [1,2,2,2]';
tol=1e-3 ;
k=0;
%% Cost Function Declaration
syms x1 x2 x3 x4
f=@(x1,x2,x3,x4)(x1+10.*x2).^2 + 5.*(x3-x4).^2 ...
    + (x2-2.*x3).^4 + 10.*(x1-x4).^2;
%% Function, Gradient, Hessian Evaluation
g      = gradient(f,[x1,x2,x3,x4]);
H      = hessian(f,[x1,x2,x3,x4]);
g0     = subs(g,{x1,x2,x3,x4},x0');
H0     = double(vpa(subs(H,{x1,x2,x3,x4},x0')));
C0     = inv(H0);
H_size = size(H0);
while true
    p     = -C0*g0 ;
    aSTAR = Linefcn(f,p,x0,5) ;
    x_k1  = x0 + aSTAR*p ;
    g     = subs(g,{x1,x2,x3,x4},x_k1') ;
    delt  = x_k1 - x0 ;
    gmma  = g - g0 ;
    a     = 1/(delt' * gmma) ;
    C0    =  inv(H0 + 1e-8*eye(H_size));
    g0    = g ;
    x0    = x_k1 ;
    if norm(g0)<tol
        break;
    end

    if k==8
        disp(double(vpa(x0)))
        break
    end
    k=k+1;
end


