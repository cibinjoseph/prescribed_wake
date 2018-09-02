#!/usr/bin/octave

clear; clc; clf;
% Beddoes model

% With collective ONLY
% No twist, coning
% Hover flight

rotor_params;

% Solver parameters 
nx = 50;                    % No. of stations along blade

% Initialization
r_bar = linspace(root_cut,tip_cut,nx);
dr_bar = r_bar(2)-r_bar(1);

calc_BEMT_inflow;

% Forward velocity consideration
lam=mean(lam_vec);

res=10;
iter=1;
plot(iter,lam,'o')
hold on;

while (res>0.0005)
  iter=iter+1;

  CT = sum(4*lam*(lam-lam_c)*r_bar.*dr_bar);
  f_lam=lam-mu*tan(alf_disk)-0.5*CT*(mu*mu+lam*lam)^(-0.5)-lam_c*cos(alf_disk);
  f_lam_prime=1+0.5*CT*(mu*mu+lam*lam)^(-1.5)*lam;

  lam_prev=lam;
  lam=lam-(f_lam)/(f_lam_prime);
  res=abs((lam-lam_prev)/lam);

  plot(iter,lam,'o')
end

return;

% Using Momentum theory
ct_vec = 4*lam.*(lam-lam_c).*r_bar.*dr_bar;
%format long;
CT = sum(ct_vec);


% Beddoes inflow approximation

%wake_skew=

% Wake markers
nrev=2;
nfil=100;
psi=linspace(0,nrev*2*pi,nfil);

xw=R*cos(psi);
yw=R*sin(psi);
zw=mean(lam)*R*psi;
