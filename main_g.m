%% Initialzation
startup()
showIP
%% Collect data
[xhat, meas] = filterTemplate;
%% Load data non corrupt data
load LG4_steady.mat

