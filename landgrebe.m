clear; clc; clf;

% Parameters
nrev=4;
dpsi_w=5*pi/180;

psi_b=nrev*(2*pi);
nw=ceil(psi_b/(dpsi_w));
CT=0.0045;
Nb=2;
sol=0.02;

psi_w=linspace(0,psi_b,nw);

% Model Coefficients
A=0.78;
LAMBDA=0.145+27*CT;
k1=-0.25*CT/sol;
k2=-1.41*sqrt(0.5*CT);

% Wake tip trajectory
r_tip=A+(1-A)*exp(-LAMBDA*psi_w);
z_tip=zeros(size(psi_w));

for i=1:length(psi_w)
  if (psi_w(i)<=2*pi/Nb)
    z_tip(i)=k1*psi_w(i);
  else
    z_tip(i)=k1*(2*pi/Nb)+k2*(psi_w(i)-2*pi/Nb);
  end
end

x_tip=r_tip.*cos(psi_b-psi_w);
y_tip=r_tip.*sin(psi_b-psi_w);

plot3(x_tip,y_tip,z_tip,'-')
grid on
axis vis3d