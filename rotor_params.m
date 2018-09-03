% Specified Rotor and Aerodynamic Parameters
R = 8.0;
c =1.0;
Nb = 1;
Om_rpm = 600;            % in rpm
a = 2*pi;%5.74;          % d_Cl/d_alpha in radians
rho = 1.2;               % in kg/m3
root_cut = 0.0;         % in r/R
tip_cut = 1.0;          % For accounting tip loss
vel_forward = 10.0;

theta=8*pi/180;

% Calculated Rotor Parameters
sol = Nb*c/(pi*R);
Om = Om_rpm*pi/30;
mu = vel_forward/(R*Om);
