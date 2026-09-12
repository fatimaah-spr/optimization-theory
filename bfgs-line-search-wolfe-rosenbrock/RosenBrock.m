% BFGS Algorithm With Line Search and Zoom Function Which uses Wolfe strong
% Condition This Code is Provided With Help Nocedal Book.
% Thanks For your Considiration

clc;
clear;
close all
%% Constant Value
x0  = [1,2]'; % Strating Point
tol = 1e-3;   % Stop Criteria 
k   =0;
%% Cost Function Defining
syms x1 x2

f = @(x1,x2)100.*(x2-x1.^2).^2 + (1-x1).^2 ;        % Objective Function

%% Strating BFGS Algortim
g     = gradient(f,[x1,x2]);    % Objective Function Gradient
H     = hessian(f,[x1,x2]) ;    % Objective Function Hessian
g0    = subs(g,{x1,x2},x0') ;   % Gradient value at x0
H     = double(vpa(subs(H,{x1,x2},x0'))) ; % Hessian Val. at x0
C0    = inv(H);                 % Hessian Inverse
Hsize = size(H);                % to use in eye martix
while true
    p      = -C0*g0;                % Descent Direction
    astar  = Linefcn(f,p,x0,2);     % a*
    x_next = x0 + astar*p;          % Next Point With a* 
    g      =subs(g,{x1,x2},x_next');% gradient value at that point
    delta   = x_next - x0;          % Delta Value
    gama   = g - g0 ;
    a = 1/(delta' * gama) ;
    C0 = double(vpa((eye(Hsize)-a*delta'*gama) ...
        *C0*(eye(Hsize)-a*gama*delta') ...
        +a*(delta*delta')));    % C Matrix 
    k=k+1;                      % Iteration Algorithm
    g0 = g ;
    x0 = x_next ;
    if norm(g0)<tol     % Stoping condition
        break;
    end
end

fprintf('Optimal Point: \n')
disp(x0)
fprintf('Function Evaluation at Optimal Point: \n')
feval=subs(f,{x1,x2},{x0'});    
disp(feval)











