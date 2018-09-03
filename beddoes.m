#!/usr/bin/octave

% Beddoes Prescribed Wake Model
% Assumptions
% 1. No climb velocity
% 2. No disk tilt

clear; clc; %clf;

rotor_params;

% Mean inflow from momentum theory at hover
poly=[1,sol*a/8,-sol*a/12*theta*(tip_cut^3-root_cut^3)/(tip_cut^2-root_cut^2)];
lam_roots=roots(poly);
lam_hover=lam_roots(1);
if (lam_roots(1)<0)
  lam_hover=lam_roots(2);
end

lam=(sqrt((0.25*(mu/lam_hover)^4)+1)-0.5*(mu/lam_hover)^2)^0.5;
lam=lam*lam_hover;

return;

% Beddoes inflow approximation
if (mu<eps)
  wake_skew=pi/2;
else
  wake_skew=atan(-lam/mu);   % Check this minus sign
end

psi_vec=linspace(0,2*pi,nx);
[R_BAR,PSI]=meshgrid(r_bar,psi_vec);
E_val=(pi/2-wake_skew)/2;
X_BAR=R_BAR.*cos(PSI);
Y_BAR=R_BAR.*sin(PSI);

lam_beddoes=lam*(1+E_val*X_BAR-E_val*abs(Y_BAR.^3));
surf(X_BAR,Y_BAR,lam_beddoes);
xlabel('X');
ylabel('Y');
grid on;

return;

% Wake markers
nrev=2;
nfil=100;
psi=linspace(0,nrev*2*pi,nfil);

xw=R*cos(psi);
yw=R*sin(psi);
zw=mean(lam)*R*psi;
