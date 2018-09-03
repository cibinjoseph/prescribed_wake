function res=lam_func(lam)
global theta root_cut tip_cut lam_c alf_disk mu sol;

dCT=@(r_bar,psi)0.5*sol*((r_bar+mu*sin(psi)).^2).*(theta-lam./r_bar);
CT=integral2(dCT,root_cut,tip_cut,0,2*pi);
res=lam-mu*tan(alf_disk)-0.5*CT*(mu*mu+lam*lam)^(-0.5)-lam_c*cos(alf_disk);
return;
