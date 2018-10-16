function [mu] = calcFrictionDataBalanced(v,random,balance,fs)
%CALCFRICTIONDATA Calculates the Friction Data for Artificial Brake Model
%   Based on the input argument v a stribeck curve is calculated
%   representing the friction data. The random argument will distort the
%   stribeck curve to achieve different signals and the balancing argument
%   balance distorts the curve such that based on how high the balancing
%   argument is, balance in % outputs will suffice the condition that at
%   some point dm/dv < 0

rng(random)

% https://de.mathworks.com/help/physmod/simscape/ref/translationalfriction.html
peak = 0.45+0.2*rand(1,1);       % height of the peak
t_peak = 0.25+random*0.1;     % at which time shall the peak occur

lowest = peak-(0.15+0.05*random)*peak; % lowest point in the Stribeck curve
f = 0.01+(random*0.05);   % viscous part with random factor
vSt = sqrt(t_peak); % random factor and balancing
vCoul = t_peak/10;



%v = t;              % maybe correlate them later


mu_complete=sqrt(2)*(peak-lowest).*exp(-(v/vSt).^2).*v/vSt+lowest.*tanh(v/vCoul)+f*v;

index_peak = floor(t_peak*fs)-4;
mu = zeros(1,length(mu_complete));
if random < balance/100 % then condition true --> normal Stribeck
    mu = mu_complete;
else
    mu(1:index_peak) = mu_complete(1:index_peak);
    mu(index_peak+1:end) = mu_complete(index_peak)*ones(1,length(mu(index_peak+1:end)))+f*v(index_peak+1:end);
end


    
    

end

