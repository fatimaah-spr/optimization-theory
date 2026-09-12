
% fatemeh soleymanpour

%hw1 num_opt
function [start_interval_opt,end_interval_opt,output_opt] = Optimization_Function(start_interval,end_interval,accuracy,epsilon,OptType)
    if (OptType == 1)
        golden_number = 0.382;
        Num_iteration = ceil(log(epsilon/(start_interval - end_interval))/log(1 - golden_number));
        i = 1;
        while (i < Num_iteration + 1) %We want to stay in the loop until the condition of Num_iteration is met. Adding +1 ensures that the condition is met,
            % whereas using only 'while (i < Num_iteration)' would result in the loop breaking before Num_iteration is reached
            x1 = start_interval + (1-golden_number)*(end_interval-start_interval);% formula from book
            x2 = end_interval - (1-golden_number)*(end_interval-start_interval);
            if (main_func(x1)<main_func(x2))
                start_interval = x2;
            elseif (main_func(x1)>main_func(x2))
                end_interval = x1;
            else
                start_interval = x1;
                end_interval = x2;
            end
            disp(['for iteration:',num2str(i)]);
            disp(['start point of the interval:',num2str(start_interval)]);
            disp(['end point of the interval:',num2str(end_interval)]);
            i = i + 1;
        end
        start_interval_opt = start_interval; % The final value of the start interval is retrieved and assigned to the output.
        %The last value of x obtained from the loop represents the optimal point
        end_interval_opt = end_interval;
        output_opt = (main_func(end_interval_opt)+main_func(start_interval_opt))/2;
    elseif(OptType == 2)

        f(1) = 1;
        f(2) = 1;
        for k = 3 : 50 % 50 is desired num
            f(k) = f(k - 1) + f(k - 2);% fibonacci series
            if (f(k) > (1+2*epsilon)*(end_interval-start_interval)/accuracy) %(a-b)*(1+2epsilon/Fn+1)<=accuracy
                break
            end
        end
        Num_iteration = length(f) - 2; % We define f1 and f2. Since the for loop starts from 3,
        % we need to subtract 2 from the length of f to account for these steps.
        % Therefore, this amount is equal to k
        q = 1;  %q is a variable used as a loop counter.

        while(q < Num_iteration + 1) % the description of this section is in the report
            rau = 1-(f(Num_iteration-q+1)/f(Num_iteration-q+2)); % calculate the rau % rau(k)=1-(FN-K+1/FN-K+2)
            if (q ~= Num_iteration)
                x1 = start_interval + (rau*(end_interval-start_interval));  % formula from book % algorithm described in the report
                x2 = start_interval + ((1-rau)*(end_interval-start_interval));
                if main_func(x1)>main_func(x2)

                    start_interval=x1;

                elseif main_func(x1)<main_func(x2)

                    end_interval=x2;

                end
            elseif(q == Num_iteration)

                if start_interval>end_interval

                    x1 = start_interval + (rau-accuracy)*(end_interval-start_interval);
                    x2 = start_interval + ((1-rau)*(end_interval-start_interval));

                elseif start_interval<end_interval

                    x1 = start_interval + (rau*(end_interval-start_interval));
                    x2 = start_interval + (1-rau+accuracy)*(end_interval-start_interval);

                end

                if main_func(x1)>main_func(x2)

                    start_interval=x1;

                elseif main_func(x1)<main_func(x2)

                    end_interval=x2;

                end

            end
            disp(['for iteration:',num2str(q)]);
            disp(['start point of the interval:',num2str(start_interval)]);
            disp(['end point of the interval:',num2str(end_interval)]);
            q = q + 1;
        end

        start_interval_opt = start_interval; % get the final value of start interval to output
        end_interval_opt = end_interval; % get the final value of end interval to output
        output_opt = (main_func(end_interval_opt)+main_func(start_interval_opt))/2; % get the mean(main_func(start interval),main_func(end interval)) to output

    end
    %% define the target function
    function y = main_func(x)
        y = x^4-14*x^3+60*x^2-70*x;
    end
end
