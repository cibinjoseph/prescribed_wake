% Specified Rotor and Aerodynamic Parameters
global root_cut tip_cut lam_c alf_disk theta mu sol;

R = 8.0;
c =1.0;
Nb = 2;
Om_rpm = 600;            % in rpm
a = 2*pi;                % d_Cl/d_alpha in radians
rho = 1.2;               % in kg/m3
root_cut = 0.05;         % in r/R
tip_cut = 0.95;          % For accounting tip loss
vel_forward = 60.0;
vel_climb = 0.0;

alf_disk = 2*pi/180;
theta=8*pi/180;

% Calculated Rotor Parameters
sol = Nb*c/(pi*R);
Om = Om_rpm*pi/30;
mu = vel_forward/(R*Om)*cos(alf_disk);
lam_c = vel_climb/(R*Om);
