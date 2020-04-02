% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
function B = B_function(parameters, one_data)  
    %% parameter declaration
    
    % permeability of free space
    muZero = 4 * pi * power(10,-7);
    
    % origin
    O = [0; 0; 0];
    
    % motor position
    P_1 = [parameters(13); parameters(17); parameters(21)];
    P_2 = [parameters(14); parameters(18); parameters(22)];
    P_3 = [parameters(15); parameters(19); parameters(23)];
    P_4 = [parameters(16); parameters(20); parameters(24)];
    P_i = [P_1 P_2 P_3 P_4];
    
    % rotation about z axis
    beta_i = [parameters(1) parameters(2) parameters(3) parameters(4)];
    
    % rotation about y axis
    gamma_i = [parameters(5) parameters(6) parameters(7) parameters(8)];
    
    % magnitude of magnets
    m_magnitude = [parameters(9) parameters(10) parameters(11) parameters(12)];
    
    % probe position
    position = one_data(1:3);
    
    % motor_orientation
    motor_orientation = one_data(4:7);
    
    %% calculation
    for n = 1:4
        R_i(:,:,n) = rotz(beta_i(n)) * roty(gamma_i(n));
        m_i(:,n) = m_magnitude(n) * R_i(:,:,n) * [cos(motor_orientation(n)); sin(motor_orientation(n)); 0];
        r_i(:,n) = position - P_i(:,n);
        B_i(:,n) = muZero / (4 * pi) / (norm(r_i(:,n))^3) * (3*(r_i(:,n) * transpose(r_i(:,n))) / norm(r_i(:,n))^2 - eye(3)) * m_i(:,n);
    end
    
    %% output
    B = transpose(sum(transpose(B_i)));
end
