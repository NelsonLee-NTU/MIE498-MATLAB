%% input data from text tile
Data = readtable('data0206');
Data(:,[1 5 10]) = [];
Data = table2array(Data);
%% processing data
x_p = Data(:,1)*0.186/100;
y_p = Data(:,2)*0.186/100;
z_p = Data(:,3)*0.186/100;

theta1 = Data(:,4);
theta2 = Data(:,5);
theta3 = Data(:,6);
theta4 = Data(:,7);

B_x = 0.001*(Data(:,8))*104.37-0.0524;
B_y = 0.001*(Data(:,9))*104.37-0.0524;
B_z = 0.001*(Data(:,10))*104.37-0.0524;

% for i=1:144
%    if(motor1(i) == 0 & motor2(i) == 0 & motor3(i) == 0 & motor4(i) == 0)
%    else 
%        MF_x(i) = NaN;
%        MF_y(i) = NaN;
%        MF_z(i) = NaN;
%    end
% end

data = [x_p y_p z_p theta1 theta2 theta3 theta4 B_x B_y B_z]
data = transpose(data);


%% plotting
subplot(3,1,1);
plot(theta4,B_x,'o');
title('MF_x - motor4');
xlabel('motor4');
ylabel('MF_x');
subplot(3,1,2);
plot(theta4,B_y,'o');
title('MF_y - motor4');
xlabel('motor4');
ylabel('MF_y');
subplot(3,1,3);
plot(theta4,B_z,'o');
title('MF_z - motor4');
xlabel('motor4');
ylabel('MF_z');