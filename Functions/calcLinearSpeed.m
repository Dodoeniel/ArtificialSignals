function [v] = calcLinearSpeed(t,a,fs)
%CALCROTORSPEED Summary of this function goes here
%   Detailed explanation goes here

vInitial = 80;     % [km/h]

v = zeros(length(t),1);
v(1) = vInitial;
for i = 2:length(t)
   v(i) = v(i-1)-1/fs*a(i);
end


end

