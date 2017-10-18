%% Initialization
clear, clc, close all

% Add paths to source and log files
addpath('./src')
addpath('./log')

% Startup procedure
startup()
showIP()
%% Collect data using original filter
[xhat, meas] = filterTemplate();
% save xhat
% save meas
%% Load datafile if necessary
load S7_steady
%load LG4_steady

%% Calculate mean and covariance
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

%% Setup figure parameters
%Set latex as default interpreter
set(groot, 'DefaultTextInterpreter', 'latex')
set(groot, 'DefaultLegendInterpreter', 'latex')
set(groot,'DefaultAxesFontSize',12)

%Parameters for plotting
cov_vec = {cov_acc,cov_gyr,cov_mag};
to_plot = {meas.acc-mu_acc, meas.gyr-mu_gyr, meas.mag-mu_mag};
sensor = {'Accelorometer','Gyroscope','Magnetometer'};
ax = {'x','y','z'};

%% Generate Histogram plots
close all
% Bins
bins = [100,100,100];
% Set plot paramters
xlimits = [0.04, 6e-3, 2];
ylimits = [600 1600 1000];
cm = colormap(lines);

% Plot for each sensor
for i=1:3
    figure(i)
    % For each axis
    for j=1:3
        subplot(3,1,j)
        % Plot histogram
        h = histogram(to_plot{i}(j,:), bins(i),'Normalization','count','FaceAlpha',1,'FaceColor',cm(j,:));
        
        % Set figure properties
        legend(['$' ax{j} '$'])
        xlim([-xlimits(i) xlimits(i)]),ylim([0 ylimits(i)])
        
        % Add title on first subplot
        if j==1
            title(['$Histograms \ of \ ' sensor{i} '$'])
        end
        % Add ylabel on mid subplot
        if j==2
            ylabel('$Count$')
        end
        if j==3
            xlabel('$Deviation \ from \ mean$')
        end
    end
    % Save image
    saveas(gca,['./fig/hist-' sensor{i}],'epsc')
end

%% Generate time plots of data
% For each sensor
for i=1:3
    subplot(3,1,i)  
    % All axes
    plot(meas.t,to_plot{i})
    % Add title
    title(['$' sensor{i} '$']),box on
    % Add legend in first subplot
    if i==1
        legend(['$' ax{1} '$'],['$' ax{2} '$'],['$' ax{3} '$'])
    end
    % Add ylabel on mid subplot
    if i==2
        ylabel('$Sensor \ value$','FontSize',15)
    end
    % Add xlabel on last subplot
    if i==3
        xlabel('$t$','FontSize',15)
    end
end
% Save figure
saveas(gca,['./fig/time-agm'],'epsc')
%% Generate One time plot for each sensor
% Define limits
ylimits = [0.05 0.01 3];
% For each sensor
for i=1:3
    figure(i)
    % All axes
    for j=1:3
        subplot(3,1,j)
        plot(meas.t,to_plot{i}(j,:),'Color',cm(j,:))
        % Add legend
        legend(['$' ax{j} '$']),ylim([-ylimits(i) ylimits(i)])
        % Add title on first plot
        if j==1
            title(['$' sensor{i} '\ Data$']),box on
        end
        % Add ylabel on mid plot
        if j==2
            ylabel('$Sensor \ value$','FontSize',15)
        end
        % Add xlabel on last subplot
        if j==3
            xlabel('$t$','FontSize',15)
        end
    end
    % Save plot
    saveas(gca,['./fig/time-' sensor{i}],'epsc')
end
% Save figure
saveas(gca,['./fig/time-agm'],'epsc')

%% Collect data using modified filter
[xhat, meas] = filterTemplate2();

%% Plot euler angles
euler_filter = q2euler(xhat.x);
euler_phone = q2euler(meas.orient);

for i=1:size(euler_filter,1)
    subplot(3,1,i),box on
    plot(xhat.t,(euler_filter(i,:)),'-','Color',cm(i,:))
    hold on
    plot(xhat.t,(euler_phone(i,:)),'k--')
    legend(['$' ax{i} '_{f}$'],['$' ax{i} '_{g}$'],'Location','NorthEast')
    
    % Add title on top subplokt
    if i==1
        title(['$Angle \ comparison \ - \ Filter \ vs \ Google$'])
    end
    % Add ylabel on mid subplot
    if i==2
        ylabel('$rad$')
    end
    % Add xlabel on last subplot
    if i==3
        xlabel('$t$')
    end
    hold off
end
saveas(gca,'./fig/comparison','epsc')
%% Collect data using modified filter
[xhat, meas] = filterTemplate2();

%% Plot euler angles
euler_filter = q2euler(xhat.x);
euler_phone = q2euler(meas.orient);

for i=1:size(euler_filter,1)
    subplot(3,1,i),box on
    plot(xhat.t,(euler_filter(i,:)),'-','Color',cm(i,:))
    hold on
    plot(xhat.t,(euler_phone(i,:)),'k--')
    legend(['$' ax{i} '_{f}$'],['$' ax{i} '_{g}$'],'Location','NorthEast')
    
    % Add title on top subplokt
    if i==1
        title(['$Angle \ comparison \ - \ Filter \ vs \ Google$'])
    end
    % Add ylabel on mid subplot
    if i==2
        ylabel('$rad$')
    end
    % Add xlabel on last subplot
    if i==3
        xlabel('$t$')
    end
    hold off
end
saveas(gca,'./fig/comparison','epsc')