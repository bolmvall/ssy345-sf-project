function  [x, P] = mu_g(x, P, yacc, Ra, g0)
    hx = Qq(x)'*g0;
    
    [Q0, Q1, Q2, Q3] = dQqdq(x);
    Q = {Q0, Q1, Q2, Q3};
    Hx = zeros(3,4);
    for i=1:size(Q,2)
       Hx(:,i) = Q{i}*g0;
    end  
    
    Sk = Hx*P*Hx'+Ra;
    Kk = P*Hx'/Sk;
       
    x = x + Kk*(yacc-hx);
    P = P-Kk*Sk*Kk';
    
    
end