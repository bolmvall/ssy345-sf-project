%% Initialzation
startup()
showIP
%% Collect data
[xhat, meas] = filterTemplate;
%% Load data non corrupt data
load LG4_steady.mat

%% Preprocess
mf = fields(meas);
xf = fields(xhat);
for i=1:size(mf,1)
    m.(mf{i}) = meas.(mf{i})(:,1:1500);
end
for i=1:size(xf,1)
    x.(xf{i}) = xhat.(xf{i})(:,1:1500);
end
%%
meas = m;
xhat = x;

%%