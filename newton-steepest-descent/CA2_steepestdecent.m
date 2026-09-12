%fatemeh soleymanpour

%hw2NumOpt
close all
clear
clc
%% Getting input from user to define the type of Function or Convergence
FuncType=input('enter "1" if you want to work with Rosenbrock Function and enter "2" if you want to work with Powell Function and enter "3" if you want a second order function for Convergence with constant value ):\n');
ConvType=input('enter "1" if you want constant Convergence otherwise enter "2":\n');
%% defining initial parameters
epsilon = 10^(-5);
start_interval=0;  
end_interval=4;  
syms x1 x2 x3 x4 alfaa;
%% deciding which Function or Convergence we wanted to work with(according to the user's input)
if (FuncType == 1)
    X_init = [1;2]; % define the initial value
    fx = inline(100*(x2-(x1)^2)^2+(1-x1)^2); % define the target function
    func_fx = @(x) fx(x(1,:),x(2,:));
    grad_fx = inline(gradient(100*(x2-(x1)^2)^2+(1-x1)^2)); 
    Gradiant_fx = @(x) grad_fx(x(1,:),x(2,:));
elseif (FuncType == 2)
    X_init = [1;2;2;2]; % define the initial value
    fx = inline((x1+10*x2)^2+5*(x3-x4)^2+(x2-2*x3)^4+10*(x1-x4)^4); 
    func_fx = @(x) fx(x(1,:),x(2,:),x(3,:),x(4,:));
    grad_fx = inline(gradient((x1+10*x2)^2+5*(x3-x4)^2+(x2-2*x3)^4+10*(x1-x4)^4)); 
    Gradiant_fx = @(x) grad_fx(x(1,:),x(2,:),x(3,:),x(4,:));

elseif (FuncType == 3)
    X_init = [1;2]; % define the initial value
    fx = inline([x1 x2]*[4 2*sqrt(2);0 5]*[x1;x2] + [x1 x2]*[3;6] + 24); % define the target function , we use that part in the last question in report, example 8.4 chong book
    func_fx = @(x) fx(x(1,:),x(2,:));
    grad_fx = inline(gradient([x1 x2]*[4 2*sqrt(2);0 5]*[x1;x2] + [x1 x2]*[3;6] + 24));
    Gradiant_fx = @(x) grad_fx(x(1,:),x(2,:));
end
%% steepest descent algorithm
x_current =  zeros(length(X_init),1); % define the value in the current iteration.
x_next    =  X_init; % define the value in the next iteration
j = 0; % function evaluation
j1 = 0; % gradient evaluation
while(norm(x_next - x_current)>10^(-3)) % stop condition.%||xk+1-xk||<=epsilon=10^-3
    x_current = x_next;
    grad_f = Gradiant_fx(x_current); 
    argo_f = func_fx(x_current-alfaa*grad_f); % calculate f(x - gradient*alfa))%alfa(k) is step size
    j1 = j1 + 1; % count gradient evaluation
    if (ConvType == 1) % constant converge
        alfa = 1/12; %constant step
    elseif(ConvType == 2)
        alfa = Gss_Function(argo_f,epsilon,start_interval,end_interval); % calculating the step size alfa based on the Golden Section Search algorithm Gss_Function 
    end
    x_next = (x_current - alfa*grad_f);
    j = j + 1; % count function evaluation
end
disp(x_next);
disp(j);
disp(j1)
disp(func_fx(x_next));
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
