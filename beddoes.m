#!/usr/bin/octave

clear; clc;
% Beddoes model

% With collective ONLY
% No twist, coning
% Hover flight

rotor_params;

% Solver parameters 
nx = 50;                    % No. of stations along blade

% Initialization
% Equi-spaced
r_bar = linspace(root_cut,tip_cut,nx);
dr_bar = r_bar(2)-r_bar(1);

calc_BEMT_inflow;

%plot(r_bar,lam);
grid on;
xlabel('Normalized Radius');
ylabel('Inflow Ratio');

% Using Momentum theory
ct_vec = 4*lam.*(lam-lam_c).*r_bar.*dr_bar;
format long;
CT_MT = sum(ct_vec);

% Using BEMT
%ct_vec = 0.5*sol*a.*dr_bar.*(r_bar.^2).*alf;
%CT_BEMT = sum(ct_vec);
% plot(r_bar,ct_vec.*(rho*pi*R*R*(R*Om)^2))

Thrust=CT_MT*(rho*pi*R*R*(R*Om)^2);

% Wake markers
nrev=2;
nfil=100;
psi=linspace(0,nrev*2*pi,nfil)

xw=R*cos(psi);
yw=R*sin(psi);
zw=mean(lam)*R*psi;
