%% runScript: 
% runs the Automobilfederung model and visualizes the results
%
% Author: Lukas Benner
% DHBW Stuttgart
% data: Q2 2022

%% mandatory
clear; clc; close all;

%% create input function
u = @(t) [(t <= 1) (t > 1)]*[0; 0.3];

%% create model
model = Automobilfederung('m1', 25,...
    'm2', 250,...
    'c1', 9e+4,...
    'c2', 3e+4,...
    'd2', 750,...
    'u', u);

%% simulate model
model.sim('t0', 0,...
    'tfinal', 3,...
    'y0', [0 0 0 0],...
    'stepsize', 0.04);
model.visualizeResults();