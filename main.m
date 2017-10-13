%% Initialization
addpath('./src')
addpath('.log')
clear 
clc
close all
startup()
showIP()
%% Collect data
% [xhat, meas] = filterTemplate();
% save xhat
% save meas
%% Load data
%load S7_steady
load LG4_steady


%% Calculate mean and covarian
%Calculate mean of sensor data
mu_acc = mean(meas.acc(:,~any(isnan(meas.acc),1)),2);
mu_gyr = mean(meas.gyr(:,~any(isnan(meas.gyr),1)),2);
mu_mag = mean(meas.mag(:,~any(isnan(meas.mag),1)),2);

%Calculate covariance of sensor data
for i=1:3
    cov_acc(i) = cov(meas.acc(i,~any(isnan(meas.acc),1)));
    cov_gyr(i) = cov(meas.gyr(i,~any(isnan(meas.gyr),1)));
    cov_mag(i) = cov(meas.mag(i,~any(isnan(meas.mag),1)));
end

%% Generate plots of data

%Set latex as default interpreter
set(groot, 'DefaultTextInterpreter', 'latex')
set(groot, 'DefaultLegendInterpreter', 'latex')

%Parameters for plotting
cov_vec = {cov_acc,cov_gyr,cov_mag};
to_plot = {meas.acc-mu_acc, meas.gyr-mu_gyr, meas.mag-mu_mag};
sensor = {'Accelorometer','Gyroscope','Magnetometer'};
ax = {'x','y','z'};

%% Generate Histogram plots
% For each sensor
bins = [100,100,20];

% Plot for each sensor
for i=1:3
    figure(i), hold on 
    % For each axis
    for j=1:3
        subplot(3,1,j)
        histogram(to_plot{i}(j,:), bins(i), 'Normalization', 'pdf')
        title(ax{j})
    end
    suptitle(['Histograms of ',sensor{i}, ' data'])
end


%% Generate time plots of data
% For each sensor
for i=1:3
    figure(i), hold on 
    % For each axis
    for j=1:3
        subplot(3,1,j)
        plot(meas.t,to_plot{i})
        title(ax{j})
    end
    suptitle(sensor{i})
end
%%
saveas(gca,'./plots/fig','epsc')
