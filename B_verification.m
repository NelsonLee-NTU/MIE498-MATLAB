function B = B_verification(ans,data)
    
    N_inputs = size(data,2);
    for i = 1:N_inputs
        B(:,i) = B_function(ans,data(:,i));
    end
    
    
end

