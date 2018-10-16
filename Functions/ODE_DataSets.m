function dydt = ODE_DataSets(t,y,steepness,maxP,fs)
%ODE_DATASETS Summary of this function goes here
%   Detailed explanation goes here

%y = [p,v]
dydt = zeros(2,1);

%% Pressure
b = 5;
t_switch = ceil(fs/steepness);
dydt(1) = maxP*steepness*exp(-steepness*t);
if t >= t_switch
   dydt(1) = dydt(1) - fs/b*cos(fs/b*t); 
end
%% Friction
peak = 1;             % height of the peak
t_peak = 0.5;         % at which time shall the peak occur
lowest = 0.8;         % lowest point in the Stribeck curve
f = 0.02;             % viscous part 
vSt = sqrt(t_peak);
vCoul = t_peak/10;
v = y(2);
mu=sqrt(2)*(peak-lowest)*exp(-(v/vSt)^2)*v/vSt+lowest*tanh(v/vCoul)+f*v;

%% Linear Speed
p = y(1);
c_pV = 38.9;
c_pH = 13.8;
r=0.3710; %  Reifenradius m
mu_const = 0.5;
m = 2565;           % [kg]
Ak_rr = sqrt(c_pV^2+c_pH^2)/(p*mu_const*2);
cp = 2*Ak_rr*mu*p;
a = cp*2/(m*r)*p;
dydt(2) =  -a;



end

