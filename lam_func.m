function res=lam_func(lam)
global root_cut tip_cut alf_disk mu;

dCT=0.5*sol*
CT=quad(dCT,root_cut,tip_cut);
res=lam-mu*tan(alf_disk)-0.5*CT*(mu*mu+lam*lam)^(-0.5);
return;
