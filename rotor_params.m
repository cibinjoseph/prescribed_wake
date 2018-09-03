% Specified Rotor and Aerodynamic Parameters
global root_cut tip_cut alf_disk theta mu sol;

R = 8.0;
c =1.0;
Nb = 1;
Om_rpm = 600;            % in rpm
a = 2*pi;%5.74;          % d_Cl/d_alpha in radians
rho = 1.2;               % in kg/m3
root_cut = 0.05;         % in r/R
tip_cut = 0.95;          % For accounting tip loss
vel_forward = 25.0;
alf_disk = 0*pi/180;
theta=8*pi/180;

% Calculated Rotor Parameters
sol = Nb*c/(pi*R);
Om = Om_rpm*pi/30;
mu = vel_forward/(R*Om)*cos(alf_disk);
