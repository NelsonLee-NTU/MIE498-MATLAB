% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
function s = B_sum_of_squared_residuals(parameters,data)
    
    %calculate number of inputs
    N_inputs = size(data,2);
    
    %calculate r_squared
    r_squared = zeros(1,N_inputs);
    
    % initialize B_measure
    B_measure = zeros(3,N_inputs);

    for i = 1:N_inputs
        %sum up r_squared
        B_measure(:,i) = [data(8,i); data(9,i); data(10,i)];
        r(:,i) = B_measure(:,i) - B_function(parameters,data(:,i));
        r_squared(i) = sum(r(:,i).^2);
%         r_x = data(8,i) - B_function(parameters,data)
%         r_squared(i) = (data(2,i) - linear_syms_function(parameters,data(1,i))).^2;
    end
    
    s = sum(r_squared);

end