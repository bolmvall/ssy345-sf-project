function  [x, P] = mu_g(x, P, yacc, Ra, g0)
% MU_Q EKF update using accelerometer measurements

    % Calculate measurement estimate
    hx = Qq(x)'*g0;
    
    % Get derivatives of Q
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    
    % Calculate Jacobian matrix 
    Hx = [Q0'*g0 Q1'*g0 Q2'*g0 Q3'*g0];
    
    % Calculate Innovation covariance and Kalman gain
    Sk = Hx*P*Hx'+Ra;
    Kk = P*Hx'/Sk;
    
    % Update x and P
    x = x + Kk*(yacc-hx);
    P = P-Kk*Sk*Kk';   
end