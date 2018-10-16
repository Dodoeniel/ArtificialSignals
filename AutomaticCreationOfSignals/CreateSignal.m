clc;
clear all;
close all;

%% Create Signal Routine
% author :  Daniel Schoepflin
% date   :  26th September 2018

%% for simplicity all signal lengths shall beo equal
fs = 10000;             % [Hz]
l = 5;                  % [s]
t = 0:1/fs:l-1/fs;   

%% Define Nnumber of TrainingSamples, Names etc
numTrainSamples = 5; % number Samples for Training
numTestSamples = 0; % number Samples for Testing
balancing = 50; % distribution of condition balancing
labelDepth = 1; % how many lables should be inclouded

TestRunName = 'TestRun1';


path = 'AutomaticCreationOfSignals/CreatedSignals/';
mkdir(['AutomaticCreationOfSignals/CreatedSignals/' TestRunName])
%% 
random = rand(numTrainSamples,1);
fid1 = fopen([path TestRunName '/NamesTraining.csv'],'w'); 
for i = 1:numTrainSamples
    % flag 1 = Training Samples
    Create1MVTimeSeries(t,fs,random(i),TestRunName,i,1, balancing, labelDepth, path, fid1);
    
end
fclose(fid1);


random = rand(numTestSamples,1);
fid1 = fopen([path TestRunName '/NamesTest.csv'],'w'); 
for i = 1:numTestSamples
    % flag 2 = Test Samples
    Create1MVTimeSeries(t,fs,random(i),TestRunName,i,2, balancing, labelDepth, path, fid1);
    
end
fclose(fid1);

