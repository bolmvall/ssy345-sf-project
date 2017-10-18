%%%%%%%%%% Part of main filter loop %%%%%%%%%%

gyr = data(1, 5:7)';
if ~any(isnan(gyr))  % Gyro measurements are available.
    [x, P] = tu_qw(x, P, gyr, t-t0-meas.t(end), Rw); % Update state estimate
    [x, P] = mu_normalizeQ(x,P); % Normalize state vector
else
    % If no measurements are available assume random walk model
    P = P + 0.001*eye(4);
end

%%%%%%%%%% Part of main filter loop %%%%%%%%%%