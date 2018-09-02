#!/usr/bin/octave

clear; clc; clf;
% Beddoes model

% With collective ONLY
% No twist, coning
% Hover flight

rotor_params;

% Solver parameters 
nx = 50;                    % No. of stations along blade
tol=0.0005;
iter_max=100;

% Initialization
r_bar = linspace(root_cut,tip_cut,nx);
dr_bar = r_bar(2)-r_bar(1);

% Change to momentum theory computed value
calc_BEMT_inflow;

% Forward velocity consideration
lam=mean(lam_vec);

res=10;
iter=1;
plot(iter,lam,'o')
hold on;

while (res>tol && iter<iter_max)
  iter=iter+1;

  CT = sum(4*lam*(lam-lam_c)*r_bar.*dr_bar);
  f_lam=lam-mu*tan(alf_disk)-0.5*CT*(mu*mu+lam*lam)^(-0.5)-lam_c*cos(alf_disk);
  f_lam_prime=1+0.5*CT*(mu*mu+lam*lam)^(-1.5)*lam;

  lam_prev=lam;
  lam=lam-(f_lam)/(f_lam_prime);
  res=abs((lam-lam_prev)/lam);

  plot(iter,lam,'o')
end

if (iter==iter_max)
  disp('Warning: Max iterations reached')
  res
end

return;

% Beddoes inflow approximation
if (mu<eps)
  wake_skew=pi/2;
else
  wake_skew=atan(lam/mu);
end

psi_vec=linspace(0,2*pi,nx);
[R_BAR,PSI]=meshgrid(r_bar,psi_vec);
E_val=wake_skew/2;
X_BAR=R_BAR.*cos(PSI);
Y_BAR=R_BAR.*sin(PSI);

lam_beddoes=lam*(1+E_val*X_BAR-E_val*abs(Y_BAR.^3));
surf(X_BAR,Y_BAR,lam_beddoes);
xlabel('X');
ylabel('Y');

return

% Wake markers
nrev=2;
nfil=100;
psi=linspace(0,nrev*2*pi,nfil);

xw=R*cos(psi);
yw=R*sin(psi);
zw=mean(lam)*R*psi;
