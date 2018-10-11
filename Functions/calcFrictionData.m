function [mu] = calcFrictionData(v,random)
%CALCFRICTIONDATA Summary of this function goes here
%   Detailed explanation goes here

% https://de.mathworks.com/help/physmod/simscape/ref/translationalfriction.html
peak = 1;             % height of the peak
t_peak = 0.5;         % at which time shall the peak occur
lowest = 0.8+random*0.4; % lowest point in the Stribeck curve
f = 0.02;             % viscous part 
vSt = sqrt(t_peak);
vCoul = t_peak/10;

%v = t;              % maybe correlate them later

mu=sqrt(2)*(peak-lowest).*exp(-(v/vSt).^2).*v/vSt+lowest.*tanh(v/vCoul)+f*v;

end

