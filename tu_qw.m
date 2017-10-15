function [x, P] = tu_qw(x, P, omega, T, Rw)
    % Get dimesion
    n = size(x,1);
    w = size(omega,1);
    % Calculate F & G
    F = eye(n)+(T/2)*Somega(omega);
    G = (T/2)*Sq(x);
    % Update x & P
    x = F*x + G*mvnrnd(zeros(w,1),Rw,1)';
    P = F*P*F' + G*Rw*G';
end