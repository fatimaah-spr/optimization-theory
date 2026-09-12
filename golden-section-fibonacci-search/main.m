close all
clear
clc

OptType=input('enter "1" if you want Gss optimization and enter "2" if you want fibonacci optimization):\n');
start_interval = 0;
end_interval = 2;
epsilon = 0.3;
accuracy = 0.1;
[start_interval_opt,end_interval_opt,output_opt] = Optimization_Function(start_interval,end_interval,accuracy,epsilon,OptType)