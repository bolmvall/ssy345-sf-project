function [x, P] = mu_m(x, P, mag, m0, Rm)
    yk = Qq(x)'*(m0);
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    Q = {Q0, Q1, Q2, Q3};
    hp = zeros(3,4);
    for i=1:size(Q,2)
       hp(:,i) = Q{i}*m0;
    end  
    Sk = hp*P*hp'+Rm;
    Kk = P*hp'/Sk;
    x = x + Kk*(mag-yk);
    P = P-Kk*Sk*Kk';
end