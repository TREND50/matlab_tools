function []=crflux(threshold)
% Expected CR flux above thresold (in eV)
% OMH 20/10/09
threshold=sscanf(threshold,'%f')%SL

index = 2.7;
maxev = 1e20;
thresgev = threshold*1e-9;  %GeV
threstev = threshold*1e-12;  %TeV
maxtev = maxev*1e-12;

delta_days = 1; %days
delta_t = delta_days*3600*24;  %s

pi = 3.1415927;
mindeg = 40;
maxdeg = 70;
theta_min = mindeg * pi/180;
theta_max = maxdeg * pi/180;  % degrees
th = theta_min:0.0001:theta_max;

%surf = 5000; %m2
%surf = 800*200; %TREND-15
%surf = 150*150; %TREND-50
%surf = 2700*500; %TREND-50
%surf = 1.3e7;
%surf = 2500*600; % GRAND-proto 
surf = (50).^2
%surf = 220e3*270e3; % GRAND
%surf = 3.14*200*200;
%surf = 3.14*500*500;  % LHASSO

disp(sprintf('Erange = %3.1e - %3.1e eV, duration = %3.1f days, ground surface = %3.1f m2',threshold,maxev,delta_days,surf))
disp(sprintf('Angular range: %3.1f - %3.1f deg -> solid angle = %3.1f sr, effective area = %3.1f m2.',mindeg,maxdeg,2*pi*trapz(th,sin(th)),surf*trapz(th,cos(th))))

solid_angle = 2*pi*trapz(th,sin(th));

a=1.8e4;
integ_flux_norm1 = a*delta_t*surf*thresgev^(-index+1)/(index-1)
%integ_flux_norm1 = a*delta_t*surf*solid_angle*thresgev^(-index+1)/(index-1)
J0=8.98e-2;
%integ_flux_norm2 = J0*delta_t*surf*solid_angle*threstev^(-index+1)/(index-1)
integ_flux_norm2 = J0*delta_t*surf*threstev^(-index+1)/(index-1)

% e=[1e17 1.8e17 3.5e17 6e17 9e17 1.7e18];
% etev=e*1e-12;
% surfeff= [0 100 2000 20000 40000 100000]; %astro-ph 1106.1164v2
% energ=trapz(etev,surfeff.*etev.^(-index));
% rice_flux = J0*delta_t*solid_angle*energ;
% 
% disp(sprintf('Expected CR-background flux in RICE = %3.3e events.',rice_flux));

