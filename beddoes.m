#!/usr/bin/octave

% Beddoes Prescribed Wake Model
clear; clc; %clf;

rotor_params;

% Solver parameters 
nx = 50;                    % No. of stations along blade
TolX=0.0005;
MaxIter=100;
relax=0.90;

% Initial value of mean inflow from momentum theory at hover
poly=[1,sol*a/8,-sol*a/12*theta*(tip_cut^3-root_cut^3)/(tip_cut^2-root_cut^2)];
lam_roots=roots(poly);
lam_init=lam_roots(1);
if (lam_roots(1)<0)
  lam_init=lam_roots(2);
end

options=optimset('TolX',TolX,'MaxIter',MaxIter);
[lam,fval,info,output]=fsolve(@lam_func,lam_init,options)

res=1;
iter=1;
% Using fsolve to solve for actual mean inflow
while (res>TolX && iter<MaxIter)
  iter=iter+1;

  dCT=@(r_bar)4*lam*(lam-lam_c)*r_bar;
  CT=quad(dCT,root_cut,tip_cut);
  f_lam=lam-mu*tan(alf_disk)-0.5*CT*(mu*mu+lam*lam)^(-0.5)+lam_c*cos(alf_disk);
  f_lam_prime=1+0.5*CT*(mu*mu+lam*lam)^(-1.5)*lam;

  lam_prev=lam;
  lam=lam-(f_lam)/(f_lam_prime);
  lam=relax*lam_prev+(1-relax)*lam;
  res=abs((lam-lam_prev)/lam);

  %plot(iter,lam,'o')
end

if (iter==MaxIter)
  disp('Warning: Max iterations reached')
  res
  return;
end

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
