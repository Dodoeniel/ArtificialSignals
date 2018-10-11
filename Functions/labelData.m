function label = labelData(p,mu,a,v,T,labelDepth,fs)
%LABELDATA Summary of this function goes here
%   Detailed explanation goes here

muLabel = Label_falling_mu(mu,fs);

if muLabel == 1
   label = 1;   
else 
   label = 0;
end

end

