% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
% input
theta_i = [pi/2 pi/2 pi/2 pi/2];
% theta_i = [0 0 0 0];
W_i = [0; 0; 0.2];

% constant
muZero = 4 * pi * power(10,-7);
O = [0; 0; 0];
P_l = 0.156 * cos(pi/6);
P_h = 0.156 * sin(pi/6);
P_i = transpose([P_l 0 P_h; 0 P_l P_h; -P_l 0 P_h; 0 -P_l P_h]);
beta_i = [0 1*pi/2 2*pi/2 3*pi/2];
gamma_i = (pi/3 + pi/2) * [1 1 1 1]; %150 degrees
m_magnitude = 1000;


% for i = 1:4
%     R_i(:,:,i) = rotz(beta_i(i)) * roty(gamma_i(i));
%     m_i(:,i) = R_i(:,:,i) * [cos(theta_i(i)); sin(theta_i(i)); 0];
%     r_i(:,i) = W_i - P_i(:,i);
%     B_i(:,i) = muZero / (4 * pi) * m_magnitude / (norm(r_i(:,i))^3) * (3*(r_i(:,i) * transpose(r_i(:,i))) - eye(3)) * m_i(:,i);    
% end


for n = 1:4
    R_i(:,:,n) = rotz(beta_i(n)) * roty(gamma_i(n));
    m_i(:,n) = R_i(:,:,n) * [cos(theta_i(n)); sin(theta_i(n)); 0];
    
    for i = 1:5
        for j = 1:5
            for k = 1:5
                testpoint_ijk(:,i,j,k) = [-0.03 + 0.01*i; -0.03 + 0.01*j; -0.03 + 0.01*k]; 
                hold on;
%                 plot3(testpoint_ijk(1,i,j,k),testpoint_ijk(2,i,j,k),testpoint_ijk(3,i,j,k),'.');
                view(3);
                r_i(:,i,j,k,n) = testpoint_ijk(:,i,j,k) - P_i(:,n);
                B_i(:,i,j,k,n) = muZero / (4 * pi) * m_magnitude / (norm(r_i(:,i,j,k,n))^3) * (3*(r_i(:,i,j,k,n) * transpose(r_i(:,i,j,k,n)))/norm(r_i(:,i,j,k,n))^2 - eye(3)) * m_i(:,n);
                
                if n == 1
                    B_itotal(:,i,j,k) = B_i(:,i,j,k,n);
                else        
                B_itotal(:,i,j,k) = B_itotal(:,i,j,k) + B_i(:,i,j,k,n);
                end
                
                
                if n == 4
                B_itotal(:,i,j,k) = B_itotal(:,i,j,k)*0.5;
                quiver3(testpoint_ijk(1,i,j,k),testpoint_ijk(2,i,j,k),testpoint_ijk(3,i,j,k),10*B_itotal(1,i,j,k),10*B_itotal(2,i,j,k),10*B_itotal(3,i,j,k),'LineWidth',2,'MaxHeadSize',0.8,'AlignVertexCenters','on');
                xlabel('x (m)');
                ylabel('y (m)');
                zlabel('z (m)');
                view(50,25);
                title('magnetic field simulation, theta = 90','FontSize',16);
                end
            end
        end
    end
    
%     R_i(:,:,n) = rotz(beta_i(n)) * roty(gamma_i(n));
%     m_i(:,n) = R_i(:,:,n) * [cos(theta_i(n)); sin(theta_i(n)); 0];
%     r_i(:,n) = W_i - P_i(:,i);
%     B_i(:,n) = muZero / (4 * pi) * m_magnitude / (norm(r_i(:,i))^3) * (3*(r_i(:,i) * transpose(r_i(:,i))) - eye(3)) * m_i(:,i);
    
    
end
% B = transpose(sum(transpose(B_i)))






