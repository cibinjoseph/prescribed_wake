% Beddoes Prescribed Wake Model
% Assumptions
% 1. No climb velocity

clear; clc; clf;

rotor_params;

% Solver parameters
nx=40;

% Mean inflow from momentum theory at hover
poly=[1,sol*a/8,-sol*a/12*theta*(tip_cut^3-root_cut^3)/(tip_cut^2-root_cut^2)];
lam_roots=roots(poly);
lam_hover=lam_roots(1);
if (lam_roots(1)<0)
  lam_hover=lam_roots(2);
end

% Actual solution for zero disk tilt used as initial guess value
lam_i=lam_hover*(sqrt((0.25*(mu/lam_hover)^4)+1)-0.5*(mu/lam_hover)^2)^0.5;
lam_init=lam_i+mu*tan(alf_disk);

% Solve non-linear inflow equation using CT computed from BET
options=optimset('TolX',0.0005,'MaxIter',100,'Display','off');
[lam,fval,info,output]=fsolve(@lam_func,lam_init,options);

if (info==1)
  fprintf('CONVERGED SOLUTION OBTAINED IN %4i ITERATIONS\n',output.iterations);
  disp([lam_hover lam_init lam])
else
  disp('ERROR: CONVERGED SOLUTION NOT OBTAINED');
  return;
end

% Beddoes inflow approximation
if (mu<eps)
  wake_skew=pi/2;
else
  wake_skew=atan(lam/mu);   % Check this minus sign
end

r_bar=linspace(root_cut,tip_cut,nx);
psi_vec=linspace(0,2*pi,nx);
[R_BAR,PSI]=meshgrid(r_bar,psi_vec);
E_val=pi/2-wake_skew;
X_BAR=R_BAR.*cos(PSI);
Y_BAR=R_BAR.*sin(PSI);

lam=lam-mu*tan(alf_disk);
lam_beddoes=lam*(1+E_val*X_BAR-E_val*abs(Y_BAR.^3));
% surf(X_BAR,Y_BAR,lam_beddoes);
% xlabel('X');
% ylabel('Y');
% grid on;

% Wake markers
nrev=10;
dpsi_w=5*pi/180;
r_tip=0.85;

psi_b=nrev*(2*pi);
nw=ceil(psi_b/(dpsi_w));

psi_w=linspace(0,psi_b,nw);

x_tip=r_tip*cos(psi_b-psi_w)+mu*psi_w;
y_tip=r_tip*sin(psi_b-psi_w);
z_tip=-mu*tan(alf_disk)*psi_w;

for i=1:length(psi_w)
  if (x_tip(i)<-r_tip*cos(psi_b-psi_w(i)))  % upstream region falling below rotor
    z_tip(i)=z_tip(i)-2*lam*(1+E_val*cos(psi_b-psi_w(i))+0.5*mu-E_val*abs(y_tip(i)^3))*psi_w(i);
%         hold on
%         plot3(x_tip(i),y_tip(i),z_tip(i),'ro')
  elseif (r_tip*cos(psi_b-psi_w(i))>0)    % downstream region
    z_tip(i)=z_tip(i)-2*lam*(1-E_val*abs(y_tip(i)^3))*psi_w(i);
%         hold on
%         plot3(x_tip(i),y_tip(i),z_tip(i),'ro')
  else    % upstream region
    z_tip(i)=z_tip(i)-2*lam*x_tip(i)*(1-E_val*abs(y_tip(i)^3))/mu;
%     hold on
%     plot3(x_tip(i),y_tip(i),z_tip(i),'ro')
  end
end

plot_wake(x_tip,y_tip,z_tip,x_tip,y_tip,z_tip,1);
%     plot(x_tip,z_tip,'b-');
%     grid on
% axis equal
