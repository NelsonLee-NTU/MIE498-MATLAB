% x = linspace(-0.2,0.2,41);
% N_points = size(x,2);
% motor_orientation = [0 0 0 0];
% 
% for i = 1:N_points
%     position = [0;x(i);0];
%     B(:,i) = magnetic_field(position, motor_orientation);
% end
% 
% plot(x,B(3,:));

x = linspace(-0.1,0.1,6000*10/15);
N_points = size(x,2);
motor_orientation = [0 0 0 0];

for i = 1:N_points
    position = [x(i);0;0];
    B(:,i) = magnetic_field(position, motor_orientation);
    if i > 1
        dB(i) = (B(:,i)-B(:,i-1))/B(:,i);
    end
    
end

plot(x,B(1,:));
plot(0.15-x,dB);
