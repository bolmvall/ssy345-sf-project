function [x, P] = tu_qw(x, P, omega, T, Rw)
% TU_QW  EKF time update step

    % Calculate F and G
    F = eye(size(x,1))+(T/2)*Somega(omega);
    G = (T/2)*Sq(x);
    
    % Update x and P
    x = F*x;
    P = F*P*F' + G*Rw*G';
end