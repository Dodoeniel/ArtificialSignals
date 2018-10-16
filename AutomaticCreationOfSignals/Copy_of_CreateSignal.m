clc;
clear all;
close all;

%% Create Signal Routine
% author :  Daniel Schoepflin
% date   :  26th September 2018

%% for simplicity all signal lengths shall be equal
fs = 100;               % [Hz]
l = 5;                  % [s]
t = 0:1/fs:l-1/fs;   

%% Define Nnumber of TrainingSamples, Names etc
numTrainSamples = 1000; % number Samples for Training
random = rand(numTrainSamples,1);
figure(1)
a= zeros(numTrainSamples,1);
b= zeros(numTrainSamples,1);
for i = 1:numTrainSamples
    mu = calcFrictionDataBalanced(t,random(i),30);
   plot(t,mu)
   a(i) = Label_muTime(mu,fs);
   b(i) = Label_falling_mu(mu,fs);
   hold on
end
nnz(a)
nnz(b)