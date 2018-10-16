function [label] = Label_muTime(mu,fs)

label = 0;
integral;
for l = 1:length(mu)
    integral = integral+ mu(l)*fs;
end

threshold = integral

if integral > threshold
    label = 1;

end

