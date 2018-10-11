function [mu] = calcFrictionDataBalanced(v,random,balance)
%CALCFRICTIONDATA Calculates the Friction Data for Artificial Brake Model
%   Based on the input argument v a stribeck curve is calculated
%   representing the friction data. The random argument will distort the
%   stribeck curve to achieve different signals and the balancing argument
%   balance distorts the curve such that based on how high the balancing
%   argument is, balance in % outputs will suffice the condition that at
%   some point dm/dv < 0

% https://de.mathworks.com/help/physmod/simscape/ref/translationalfriction.html
peak = 0.5;       % height of the peak
t_peak = 0.3;     % at which time shall the peak occur

lowest = peak-0.2*peak; % lowest point in the Stribeck curve
f = 0.01+(random*0.015);   % viscous part with random factor
vSt = sqrt(t_peak)*(1.5-balance/100+random*7.2); % random factor and balancing
vCoul = t_peak/10;



%v = t;              % maybe correlate them later

mu=sqrt(2)*(peak-lowest).*exp(-(v/vSt).^2).*v/vSt+lowest.*tanh(v/vCoul)+f*v;

end

