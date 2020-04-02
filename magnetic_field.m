% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
function output = magnetic_field(position, motor_orientation)
    
    %% parameter declaration
    muZero = 4 * pi * power(10,-7); % permeability of free space
    O = [0; 0; 0]; % origin
    P_l = 0.156 * cos(pi/6); % vertical distance of motor
    P_h = 0.156 * sin(pi/6); % horizontal distance of motor
    P_i = transpose([P_l 0 P_h; 0 P_l P_h; -P_l 0 P_h; 0 -P_l P_h]); % position of four motors
    beta_i = [0 1*pi/2 2*pi/2 3*pi/2]; % rotation about z axis
    gamma_i = (pi/3 + pi/2) * [1 1 1 1]; % rotation about y axis (150 degrees)
    m_magnitude = 150; % magnetic moment
    
    %% calculation
    for n = 1:4
        R_i(:,:,n) = rotz(beta_i(n)) * roty(gamma_i(n));
        m_i(:,n) = m_magnitude * R_i(:,:,n) * [cos(motor_orientation(n)); sin(motor_orientation(n)); 0];
        r_i(:,n) = position - P_i(:,n);
        B_i(:,n) = muZero / (4 * pi) / (norm(r_i(:,n))^3) * (3*(r_i(:,n) * transpose(r_i(:,n)) / norm(r_i(:,n))^2) - eye(3)) * m_i(:,n);
    end
    
    %% output
    output = transpose(sum(transpose(B_i)))

end


% function output = magnetic_field(position, motor_orientation)
%     
%     %% parameter declaration
%     muZero = 4 * pi * power(10,-7); % permeability of free space
%     O = [0; 0; 0]; % origin
%     P_l = 0.156 * cos(pi/6); % vertical distance of motor
%     P_h = 0.156 * sin(pi/6); % horizontal distance of motor
%     P_i = transpose([0.156 0 0; 0 P_l P_h; -P_l 0 P_h; 0 -P_l P_h]); % position of four motors
%     beta_i = [0 1*pi/2 2*pi/2 3*pi/2]; % rotation about z axis
%     gamma_i = (pi/2 + pi/2) * [1 1 1 1]; % rotation about y axis (150 degrees)
%     m_magnitude = 150; % magnetic moment
%     
%     %% calculation
%     for n = 1:1
%         R_i(:,:,n) = rotz(beta_i(n)) * roty(gamma_i(n));
%         m_i(:,n) = m_magnitude * R_i(:,:,n) * [cos(motor_orientation(n)); sin(motor_orientation(n)); 0];
%         r_i(:,n) = position - P_i(:,n);
%         B_i(:,n) = muZero / (4 * pi) / (norm(r_i(:,n))^3) * (3*(r_i(:,n) * transpose(r_i(:,n)) / norm(r_i(:,n))^2) - eye(3)) * m_i(:,n);
%     end
%     
%     %% output
%     output = transpose(sum(transpose(B_i)))
% 
% end