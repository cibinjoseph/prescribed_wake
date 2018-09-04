clear; clc; clf;

% Parameters
nrev=4;
dpsi_w=5*pi/180;

psi_b=nrev*(2*pi);
nw=ceil(psi_b/(dpsi_w));
CT=0.0045;
Nb=2;
sol=0.02;
theta_twist_deg=-8;

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

plot3(x_tip,y_tip,z_tip,'b-')
hold on
plot3(x_tip*0.2,y_tip*0.2,z_root,'r-')
grid on
axis vis3d