function [p] = calcPressure(t,fs,random)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

steepness = 5;
max = 35;
sinusFreq= 5;
p = max-max*exp(-(steepness+random).*t);
t_switch = ceil(fs/steepness);
p(t_switch:end) = p(t_switch:end)-sin(fs/sinusFreq*t(t_switch:end));
end

