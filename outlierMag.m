%%%%%%%%%% Part of main filter loop %%%%%%%%%%

mag = data(1, 8:10)';
if ~any(isnan(mag))  % Mag measurements are available.
    % AR-filter to account for that the magnitude of m0 might drift
    Lk = (1-alpha)*Lk + alpha*norm(mag);
    
    % If magnitude of measurement is too small or large, skip update step
    if 35<Lk && Lk<55 % Thresholds for magnetic field
        [x, P] = mu_m(x, P, mag, m0, Rm); % Update state estimate
        [x, P] = mu_normalizeQ(x,P); % Normalize state vector
        magOut = 0;
    else
        magOut = 1;
    end
end

%%%%%%%%%% Part of main filter loop %%%%%%%%%%