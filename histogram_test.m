% AUTHOR: Kuan-Ting Lee
% DATE: April 2nd 2020
%% Measured Magnetic field
clear
file_read = 'data0320(7)';
data = get_data(file_read);
B_measured = data(8:10,:);
B_measured_strength = sum(B_measured.^2).^0.5;

%% guessing parameter
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

Npoints = size(data,2);
for i=1:Npoints
   B_guessed(:,i) = B_function(guessing_parameter,data(:,i));
end

%% Calibration

fun_opt = @(x) B_sum_of_squared_residuals(x,data);

% constraints
A = [0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0];
b = [0 0 0 0];
Aeq = [];
beq = [];
lb = [];
ub = [];
options = optimset('Algorithm', 'interior-point','Display','iter-detailed','PlotFcns','optimplotfval','TolX',1e-9,'TolCon',1e-3,'MaxIter',10,'MaxFunEvals', 200e4);

[x,fval,exitflag,output] = fmincon(fun_opt, guessing_parameter, A, b, Aeq, beq, lb, ub, [], options)

%% Calibrated parameter
calibrated_parameter = x;
for i=1:Npoints
    B_calibrated(:,i) = B_function(calibrated_parameter,data(:,i));
end

% calculation for coefficient of determination
B_m_av = transpose(sum(transpose(B_measured)))./Npoints;
SS_m_tot = sum(transpose(sum(transpose((B_measured - B_m_av).^2))));
SS_m_reg = sum(transpose(sum(transpose((B_guessed - B_m_av).^2))));
SS_m_res = sum(transpose(sum(transpose((B_measured - B_guessed).^2))));

SS_c_tot = sum(transpose(sum(transpose((B_calibrated - B_m_av).^2))));
SS_c_reg = sum(transpose(sum(transpose((B_guessed - B_m_av).^2))));
SS_c_res = sum(transpose(sum(transpose((B_measured - B_calibrated).^2))));

r2_measured = 1 - (SS_m_res/SS_m_tot);
r2_calibrated = 1 - (SS_c_res/SS_c_tot);

% Error calculation
errorx_guessed = (B_guessed(1,:) - B_measured(1,:))./B_measured(1,:)*100;
errory_guessed = (B_guessed(2,:) - B_measured(2,:))./B_measured(2,:)*100;
errorz_guessed = (B_guessed(3,:) - B_measured(3,:))./B_measured(3,:)*100;

errorx_calibrated = (B_calibrated(1,:) - B_measured(1,:))./B_measured(1,:)*100;
errory_calibrated = (B_calibrated(2,:) - B_measured(2,:))./B_measured(2,:)*100;
errorz_calibrated = (B_calibrated(3,:) - B_measured(3,:))./B_measured(3,:)*100;

error_guessed = sum((B_guessed - B_measured).^2).^0.5./B_measured_strength*100;
error_calibrated = sum((B_calibrated - B_measured).^2).^0.5./B_measured_strength*100;

% mean_error_guessed = mean(error_guessed);
% mean_error_calibrated = mean(error_calibrated);
% 
% std_error_guessed = sum(transpose(((error_guessed - mean_error_guessed).^2)))^0.5/Npoints^0.5;
% std_error_calibrated = sum(transpose(((error_calibrated - mean_error_calibrated).^2)))^0.5/Npoints^0.5;

std_error_guessed = std(error_guessed);
std_errorx_guessed = std(errorx_guessed);
std_errory_guessed = std(errory_guessed);
std_errorz_guessed = std(errorz_guessed);

std_error_calibrated = std(error_calibrated);
std_errorx_calibrated = std(errorx_calibrated);
std_errory_calibrated = std(errory_calibrated);
std_errorz_calibrated = std(errorz_calibrated)



% Histogram plot
nbins = 250;

subplot(3,1,1);
h = histogram(errorx_guessed);
h.BinLimits = [-100 100];
h.BinWidth = 2;
hold on
h = histogram(errorx_calibrated);
h.BinLimits = [-100 100];
h.BinWidth = 2;
hold off
lgd = legend('original error','calibrated error');
lgd.FontSize = 10;
title('error distribution in X','FontSize',16);
xlabel('error (%)');
ylabel('counts');

subplot(3,1,2);
h = histogram(errory_guessed,nbins);
h.BinLimits = [-100 100];
h.BinWidth = 2;
hold on
h = histogram(errory_calibrated,nbins);
h.BinLimits = [-100 100];
h.BinWidth = 2;
hold off
lgd = legend('original error','calibrated error');
lgd.FontSize = 10;
title('error distribution in Y','FontSize',16);
xlabel('error (%)');
ylabel('counts');

subplot(3,1,3);
h = histogram(errorz_guessed,nbins);
h.BinLimits = [-100 100];
h.BinWidth = 2;
hold on
h = histogram(errorz_calibrated,nbins);
h.BinLimits = [-100 100];
h.BinWidth = 2;
hold off
lgd = legend('original error','calibrated error');
lgd.FontSize = 10;
title('error distribution in Z','FontSize',16);
xlabel('error (%)');
ylabel('counts');
saveto = strcat(file_read,'xyz','.png');
saveas(h,saveto);

figure
h = histogram(error_guessed,nbins);
h.BinLimits = [0 100];
h.BinWidth = 1;
hold on
h = histogram(error_calibrated,nbins);
h.BinLimits = [0 100];
h.BinWidth = 1;
lgd = legend('original error','calibrated error');
lgd.FontSize = 16;
title('error distribution','FontSize',16);
xlabel('error (%)');
ylabel('counts');

saveas(h,strcat(file_read,'.png'));
