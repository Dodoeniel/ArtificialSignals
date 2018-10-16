function [label] = Label_falling_mu(mu,fs)
%LABEL_FALLING_MU2
%   Detailed explanation goes here

mu_half = mu(1:floor(length(mu)/2));
max_entry = find(mu_half == max(mu_half));

if max_entry == floor(length(mu)/2)     % if maximum is at half of signal
   label = 0;
elseif min(mu(max_entry:floor(length(mu)/2))) < mu_half(max_entry) 
   label = 1;
end

end

