function [x, P] = mu_m(x, P, mag, m0, Rm)
% MU_M EKF update using magnetometer measurements

    % Calculate measurement estimate
    hx = Qq(x)'*m0;
    
    % Get derivatives of Q
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    
    % Calculate Jacobian matrix 
    Hx = [Q0'*m0 Q1'*m0 Q2'*m0 Q3'*m0];
    
    % Calculate Innovation covariance and Kalman gain
    Sk = Hx*P*Hx'+Rm;
    Kk = P*Hx'/Sk;
    
    % Update x and P
    x = x + Kk*(mag-hx);
    P = P-Kk*Sk*Kk';
end