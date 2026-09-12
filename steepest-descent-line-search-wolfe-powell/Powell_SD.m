%% *Description*

% This is Code For Powell Funtion Where Two zoom and Line Search Algorithms
% Are From Nocedal Book p.81 It is Important to Notice That Cause We have 4
% Variables To Optimize inCost Function, Code Excution Take a bit Longer
% than Rosen Brock And it's About 500 sec. So please Wait Until you see the
% Result:)
tic
clc; clear; close all;
%% *Define Constant Values*

x0 = [1,2,2,2]';  % Starting Point
tol=1e-3;         % Stoping Criteria Of Alg.
%% *Define Objective Function*

syms x1 x2 x3 x4
Obj=@(x1,x2,x3,x4)(x1+10.*x2).^2 + 5.*(x3-x4).^2 + (x2-2.*x3).^4 + 10.*(x1-x4).^2;
%% *Steepset Descent Algorithm*

f0    = subs(Obj,{x1,x2,x3,x4},x0');      % Function Eval. At x0
g     = gradient(Obj,[x1,x2,x3,x4]);      % Gradient Calc.
g_val = subs(g,{x1,x2,x3,x4},x0');        % Gradient Eval. At x0
i     = 1;                                % Iteration Counter
while true
    d     = -g_val;                        % Descent Direction
    a     = linefcn(Obj,d,x0,5);           % Line Search Function
    L_x0  = x0;                            % Store Last x0 Point
    x0    = double(vpa(x0+a*d));           % New x0 With New Descent 
    f0    = subs(Obj,{x1,x2,x3,x4},{x0'}); % Func. Eval
    g_val = subs(g,{x1,x2,x3,x4},{x0'});   % Grad. Eval

    if norm(x0-L_x0) < tol          % Stoping Criteria
        fprintf("Iteration %d , new Point is: :\n",i)
        disp(x0)
        feval = double(vpa(subs(Obj,{x1,x2,x3,x4},{x0'})));
        fprintf("function value at optimized point:%d\n",feval)
        fprintf("||x0 - L_x0||=%d\n\n",norm(x0-L_x0))
        break;
    end    
i        = i+1;
fsave(i) = f0;      % To Plot At Each Iteration
end
dataPlot = [fsave,feval];
plot(dataPlot,'LineWidth',1.5,'Color','r')
xlabel('Iteration')
ylabel('Function Eval. at Point x0')
toc