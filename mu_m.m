function [x, P] = mu_m(x, P, mag, m0, Rm)
    hx = Qq(x)'*m0;    
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    Q = {Q0, Q1, Q2, Q3};
    Hx = zeros(3,4);
    for i=1:size(Q,2)
       Hx(:,i) = Q{i}*m0;
    end  
    Sk = Hx*P*Hx'+Rm;
    Kk = P*Hx'/Sk;
    x = x + Kk*(mag-hx);
    P = P-Kk*Sk*Kk';
end