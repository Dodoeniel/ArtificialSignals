function [v,a,mu,p,T] = Create1MVTimeSeries(t,fs,random, name, count, flag, balancing, labelDepth, path, fid1)
%CREATE1MVTIMESERIES Outputs a multi-variate Time Series
%   author: Daniel Schoepflin
%   date : 26th September 2018

p = calcPressure(t,fs,random);             
mu = calcFrictionDataBalanced(t,random,balancing);  % calculated with time not speed!
a = calcDeccelleration(t,p,mu);
v = calcLinearSpeed(t,a,fs)';
T = calcTemperature(t,v,fs)';
label = labelData(p,mu,a,v,T,labelDepth,fs);


if flag == 1    %% flag 1 TrainingData
    
    csvwrite([path name '/' name '_Training' '_' int2str(count) '.csv'],[v' a' mu' p' T']);
    str = [name '_Training_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
%    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/NamesTraining.csv'],name,'-append');
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsTraining.csv'],label,'-append');

elseif flag == 2 %% flag 2 TestingData
    
    csvwrite([path name '/' name '_Test' '_' int2str(count) '.csv'],[v' a' mu' p' T']);
    str = [name '_Training_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
%    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/NamesTest.csv'],name,'-append');
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsTest.csv'],label,'-append');

end

% figure(2)
% subplot(5,1,1)
% plot(t,v);
% title('Velocity')
% 
% subplot(5,1,2)
% plot(t,a);
% title('Deccelleration')
% 
% subplot(5,1,3)
% plot(t,mu);
% title('Friction')
% 
% subplot(5,1,4)
% plot(t,p);
% title('Pressure')
% 
% subplot(5,1,5)
% plot(t,T);
% title('Temperature')

end

