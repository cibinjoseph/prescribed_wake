
const1 = sol*a/16; 
const_c = lam_c*0.5;

% Inflow ratio from BEMT
lam_vec = -(const1-const_c) + sqrt((const1-const_c)^2+2*const1*theta*r_bar);
alf=theta-lam_vec./r_bar;
