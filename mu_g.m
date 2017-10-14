function  [x, P] = mu_g(x, P, yacc, Ra, g0)
    n = size(yacc,1);
    yk = Qq(x)'*(g0) ;%+ mvnrnd(zeros(n,1),Ra,1)';
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    Q = {Q0, Q1, Q2, Q3};
    hp = zeros(3,4);
    for i=1:size(Q,2)
       hp(:,i) = Q{i}*g0;
    end  
    Sk = hp*P*hp'+Ra;
    Kk = P*hp'/Sk;
    x = x + Kk*(yacc-yk);
    P = P-Kk*Sk*Kk';
end