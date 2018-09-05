clear; clc; clf;

% Parameters
nrev=4;
dpsi_w=5*pi/180;

R=8;
c=0.5;
psi_b=nrev*(2*pi);
nw=ceil(psi_b/(dpsi_w));
CT=0.0045;
Nb=1;
sol=Nb*c/(pi*R);
theta_twist_deg=-8;
root_coordinate=0.2;  % r/R

psi_w=linspace(0,psi_b,nw);

% Model Coefficients
A=0.78;
LAMBDA=0.145+27*CT;
k1=-0.25*(CT/sol+0.001*theta_twist_deg);
k2=-(1.41+0.0141*theta_twist_deg)*sqrt(0.5*CT);
k2_tip=(theta_twist_deg/128*(0.45*theta_twist_deg+18))*sqrt(0.5*CT);

% Wake tip trajectory
r_tip=A+(1-A)*exp(-LAMBDA*psi_w);
r_root=r_tip;
z_tip=zeros(size(psi_w));
z_root=zeros(size(psi_w));

for i=1:length(psi_w)
  if (psi_w(i)<=2*pi/Nb)
    z_tip(i)=k1*psi_w(i);
  else
    z_tip(i)=k1*(2*pi/Nb)+k2*(psi_w(i)-2*pi/Nb);
  end
  
  if (psi_w(i)<=pi/2)
    z_root(i)=0;
  else
    z_root(i)=k2_tip*(psi_w(i)-pi/2);
  end
end

x_tip=r_tip.*cos(psi_b-psi_w);
y_tip=r_tip.*sin(psi_b-psi_w);

x_root=x_tip*root_coordinate;
y_root=y_tip*root_coordinate;

plot_wake(x_root,y_root,z_root,x_tip,y_tip,z_tip,1);
title(['CT=',num2str(CT),',   \sigma=',num2str(sol)]); 
set(gca,'FontSize',14,'fontWeight','bold');