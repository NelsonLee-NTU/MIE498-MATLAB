% plot3(1,1,1,'o');
% hold on;
% plot3(1,1,2,'o');
% plot3(1,2,1,'o');
% plot3(1,2,2,'o');
% plot3(2,1,1,'o');
% plot3(2,1,2,'o');
% plot3(2,2,1,'o');
% plot3(2,2,2,'o');

% x = -3:0.5:3;
% y = -3:0.5:3;
% [X,Y] = meshgrid(x, y);
% Z = Y.^2 - X.^2;
% [U,V,W] = surfnorm(Z);
% 
% figure
% quiver3(Z,U,V,W)
% view(-35,45)

x = -0.05:0.01:0.05;
y = -0.05:0.01:0.05;
z = -0.05:0.01:0.05;

plot3(x,y,z);
