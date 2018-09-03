function res=lam_func(lam)
global root_cut tip_cut alf_disk mu lam_c;

[root_cut tip_cut alf_disk mu lam_c];

dCT=@(r_bar)4*lam*lam*r_bar;
CT=quad(dCT,root_cut,tip_cut);
res=lam-mu*tan(alf_disk)-0.5*CT*(mu*mu+lam*lam)^(-0.5)-lam_c*cos(alf_disk);
return;
