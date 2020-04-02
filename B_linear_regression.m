% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
data = get_data('data0320(4)');

fun_opt = @(x) B_sum_of_squared_residuals(x,data);

A = [0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0];
b = [0 0 0 0];

Aeq = [];
beq = [];
lb = [];
ub = [];
g_beta = [0 1*pi/2 2*pi/2 3*pi/2];
g_gamma = (pi/3 + pi/2) * [1 1 1 1];
g_m = [150 150 150 150];

P_l = 0.156 * cos(pi/6); % vertical distance of motor
P_h = 0.156 * sin(pi/6); % horizontal distance of motor
P_i = transpose([P_l 0 P_h; 0 P_l P_h; -P_l 0 P_h; 0 -P_l P_h]);
g_x = P_i(1,:);
g_y = P_i(2,:);
g_z = P_i(3,:);

guessing_parameter = [g_beta g_gamma g_m g_x g_y g_z];

options = optimset('Algorithm', 'interior-point','Display','iter-detailed','PlotFcns','optimplotfval','TolX',1e-9,'TolCon',1e-3,'MaxIter',30,'MaxFunEvals', 200e4);

[x,fval,exitflag,output] = fmincon(fun_opt, guessing_parameter, A, b, Aeq, beq, lb, ub, [], options)

