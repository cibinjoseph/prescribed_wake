% Specified Rotor and Aerodynamic Parameters
R = 10.0;
c =0.4;
Nb = 1;
Om_rpm = 250;            % in rpm
a = 2*pi;%5.74;                   % d_Cl/d_alpha in radians
rho = 1.2;                % in kg/m3
root_cut=0.05;
tip_cut=0.95;      % For accounting tip loss
vel_climb = 0.0;

theta=15*pi/180;

% Calculated Rotor Parameters
sol = Nb*c/(pi*R);
Om = Om_rpm*pi/30;
lam_c = vel_climb/(R*Om);
