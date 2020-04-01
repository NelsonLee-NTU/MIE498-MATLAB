function data = get_data(file);
    %% input data from text tile
    Data = readtable(file);
    Data(:,[1 5 10]) = [];
    Data = table2array(Data);
    %% processing data
    x_p = Data(:,1)*0.186/100000;
    y_p = Data(:,2)*0.186/100000;
    z_p = Data(:,3)*0.186/100000;

    theta1 = Data(:,4);
    theta2 = Data(:,5);
    theta3 = Data(:,6);
    theta4 = Data(:,7);

    B_x = 0.001*((Data(:,8))*104.37-0.0524);
    B_y = 0.001*((Data(:,9))*104.37-0.0524);
    B_z = 0.001*((Data(:,10))*104.37-0.0524);

    % output data
    data = [x_p y_p z_p theta1 theta2 theta3 theta4 B_x B_y B_z]
    data = transpose(data);
end