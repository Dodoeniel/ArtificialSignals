function [label] = Label_falling_muTime(mu,fs)
%LABEL_FALLING_MU Outputs the label for a set of adjacent falling rms
%values 
%   Detailed explanation goes here

num = 10;       % number of consecutive samples needed

jump = fs/1000; % number of steps for rms value
vec = zeros(num,jump);  % preallocation matrix of slized vectors
RMS = zeros(num,1);     % preallocation vector of RMS values slized vectors
label = 0;              % presetting of label to false

%% outer loop over the signal
for i = 1:floor(length(mu)/jump)-num*jump
    
    % slicing the signal in num vectors
    for l = 1:num
        vec(l,:) = mu(i+l-1:i+l+jump-2);
    end
    % calculating the RMS values of each slice
    for l = 1:length(vec(1,:))
        RMS(l) = rms(vec(:,l));
    end
    % calculating the adjacent differences
    differences = -diff(RMS);
    % checking if any difference is above zero --> no declining
    check = zeros(length(differences),1);   
    for l = 1:length(differences)
       if differences(l) < 0
             check(l) = 1;
       end
    end
    if prod(check) ~= 0
        label = 1;         % if product of check elements nonzero --> true
    end
    
end

end

