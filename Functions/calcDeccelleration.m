function [a,cp] = calcDeccelleration(t,p,mu)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

c_pV = 38.9;
c_pH = 13.8;
r=0.3710; %  Reifenradius m
mu_const = 0.5;
m = 2565;           % [kg]
Ak_rr = sqrt(c_pV^2+c_pH^2)./(p*mu_const*2);
cp = 2.*Ak_rr.*mu.*p;
cp(1) = 0;
a = cp*2/(m*r).*p;
end

