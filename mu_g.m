function  [x, P] = mu_g(x, P, yacc, Ra, g0)
    hx = Qq(x)'*g0;
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    Hx = [Q0'*g0 Q1'*g0 Q2'*g0 Q3'*g0];
    Sk = Hx*P*Hx'+Ra;
    Kk = P*Hx'/Sk;
    x = x + Kk*(yacc-hx);
    P = P-Kk*Sk*Kk';   
end