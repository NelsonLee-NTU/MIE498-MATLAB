% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
x = [0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
y = [0 0 0 1 1 1 -1 -1 -1 0 0 0 1 1 1 -1 -1 -1 0 0 0 1 1 1 -1 -1 -1];
z = [0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2 0 1 2];
hold on
plot3(x(1:9),y(1:9),z(1:9),'.','MarkerSize',20);
plot3(x(10:18),y(10:18),z(10:18),'.','MarkerSize',20,'Color',[1 0 0]);
plot3(x(19:27),y(19:27),z(19:27),'.','MarkerSize',20,'Color',[0 1 0]);
xlabel('x (cm)','FontSize',14);
ylabel('y (cm)','FontSize',14);
zlabel('z (cm)','FontSize',14);
xlim([-1 1]);
ylim([-1 1]);
zlim([0 2]);
axis equal
view(42,22);
grid on