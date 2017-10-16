function [x, P] = mu_m(x, P, mag, m0, Rm)
    hx = Qq(x)'*m0;    
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    Hx = [Q0'*m0 Q1'*m0 Q2'*m0 Q3'*m0];
    Sk = Hx*P*Hx'+Rm;
    Kk = P*Hx'/Sk;
    x = x + Kk*(mag-hx);
    P = P-Kk*Sk*Kk';
end