%fatemeh soleymanpour

%hw2NumOpt
close all
clear
clc
%% defining initial parameters
syms x1 x2 x3 x4 alfaa;
epsilon = 10^(-5);
start_interval=0;  
end_interval=4;  
%% Getting input from user to define the type of Function or Convergence
FuncType=input('enter "1" if you want to work with Rosenbrock Function and enter "2" if you want to work with Powell Function):\n');
%% deciding which Function or Convergence we wanted to work with(according to the user's input)
if (FuncType == 1)
    X_init = [1;2]; % define the initial value1
    fx = inline(100.*(x2-x1.^2).^2 + (1-x1).^2); % define the target function
    func_fx = @(x) fx(x(1,:),x(2,:));
    grad_fx = inline(gradient(100.*(x2-x1.^2).^2 + (1-x1).^2)); 
    Gradiant_fx = @(x) grad_fx(x(1,:),x(2,:)); 
    hess_fx = inline(hessian(100.*(x2-x1.^2).^2 + (1-x1).^2)); 
    Hessian_fx = @(x) hess_fx(x(1,:),x(2,:));
elseif (FuncType == 2)
    X_init = [1;2;2;2]; % define the initial value
    fx = inline((x1+10*x2)^2+5*(x3-x4)^2+(x2-2*x3)^4+10*(x1-x4)^4); % define the target function
    func_fx = @(x) fx(x(1,:),x(2,:),x(3,:),x(4,:));
    grad_fx = inline(gradient((x1+10*x2)^2+5*(x3-x4)^2+(x2-2*x3)^4+10*(x1-x4)^4)); 
    Gradiant_fx = @(x) grad_fx(x(1,:),x(2,:),x(3,:),x(4,:));
    hess_fx = inline(hessian((x1+10*x2)^2+5*(x3-x4)^2+(x2-2*x3)^4+10*(x1-x4)^4));
    Hessian_fx = @(x) hess_fx(x(1,:),x(2,:),x(3,:),x(4,:));
end
%% Newton algorithm
j=0; j1=0; j2=0; 
x_current =  zeros(length(X_init),1); 
x_next    =  X_init; % define the value in the next iteration
while(norm(x_next - x_current)>10^(-3)) 
    x_current = x_next;
    grad_f = Gradiant_fx(x_current); 
    j1=j1+1;% count gradient evaluation
    hesian_f_=Hessian_fx(x_current); 
    j2=j2+1; % count hessian evaluation
    if hesian_f_ <= 0 
        landa=abs(eig(hesian_f_));
        hesian_f_=hesian_f_+(landa+0.0000001);
    end
    H = -inv(hesian_f_)*grad_f; 
    argo_f=func_fx(x_current+alfaa*H); % like SD algorithm 
    alfa = Gss_Function(argo_f,epsilon,start_interval,end_interval); % calculating the step size alfa based on the Golden Section Search algorithm Gss_Function
    x_next=(x_current+alfa*H); %xk+1=xk-alfa*(-inv(hesian_f_)*grad_f) % step3 in algorithm
    j=j+1;
end
disp(x_next);
disp(j);
disp(j1);
disp(j2);
disp(double(func_fx(x_next)));

%% Gss Function
function [output_opt] = Gss_Function(f,epsilon,start_interval,end_interval)
    syms alfaa;
    golden_number = 0.382;
    Num_iteration = ceil(log(epsilon/(start_interval - end_interval))/log(1 - golden_number));
    i = 1;
    while (i < Num_iteration + 1)
        x1 = start_interval + (1-golden_number)*(end_interval-start_interval);
        x2 = end_interval - (1-golden_number)*(end_interval-start_interval);
        if subs(f,alfaa,x1)<subs(f,alfaa,x2)
            start_interval = x2;
        elseif subs(f,alfaa,x1)>subs(f,alfaa,x2)
            end_interval = x1;
        else
            start_interval = x1;
            end_interval = x2;
        end
        i = i + 1;
    end
    output_opt = (start_interval + end_interval)/2;
end