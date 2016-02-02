clear all
close all

% ------ %
% test 1 %
% ------ %

% load files
obs_file_name = 'data/test_1/wl_2013.mat';
tel_file_name{1} = 'data/test_1/ss_101_a_10.mat';
tel_file_name{2} = 'data/test_1/ss_101_b_10.mat';
tel_file_name{3} = 'data/test_1/ss_101_c_10.mat';
tel_file_name{4} = 'data/test_1/ss_101_d_10.mat';
tel_file_name{5} = 'data/test_1/ss_101_e_10.mat';
tel_file_name{6} = 'data/test_1/ss_104_f_10.mat';
tel_file_name{7} = 'data/test_1/ss_104_g_10.mat';
tel_file_name{8} = 'data/test_1/ss_104_h_10.mat';
tel_file_name{9} = 'data/test_1/ss_104_i_10.mat';

% selected period: from 1/7/2013 to 1/8/2013
time_start = datenum('01-Jul-2013');
time_stop  = datenum('01-Aug-2013');

% load observations
obs = load(obs_file_name);

% only keep observations in the selected period
ind_obs = find((obs.time < time_start) + (obs.time > time_stop));
obs.time = obs.time(ind_obs);
obs.data = obs.data(ind_obs, :);

% load first result file
tel{1} = load(tel_file_name{1});

% indices of observations and model results occuring at the same time
[~, ind_obs, ind_tel] = intersect(obs.time, tel{1}.time);

% only keep observations when there are model results
obs.time = obs.time(ind_obs);
obs.data = obs.data(ind_obs, :);

% for each simulation
for i = 1:length(tel_file_name)

    % load results
    tel{i} = load(tel_file_name{i});

    % only keep model results when there are observations
    tel{i}.time = tel{i}.time(ind_tel);
    tel{i}.data = tel{i}.data(ind_tel, :);

    % MSL to TAW
    tel{i}.data = tel{i}.data + 2.333;

end

% keep observation and results at stations Appelzak, Bol van Heist, Bol van
% Knokke and Wandelaar
obs_id = [1 2 3 6];

% initialize final matrix
mat = zeros(length(obs.time) + 1, ...
            length(obs_id) * (length(tel_file_name) + 1));

% for each station
for i = 1:length(obs_id)
    
    % observation at ith station
    mat(1, (i - 1) * (length(tel_file_name) + 1) + 1) = 0;
    mat(2:end, (i - 1) * (length(tel_file_name) + 1) + 1) = ...
        obs.data(:, obs_id(i));
    
    % for each simulation
    for j = 1:length(tel_file_name)
        
        mat(1, (i - 1) * (length(tel_file_name) + 1) + 1 + j) = ...
            (i - 1) * (length(tel_file_name) + 1) + 1;
        mat(2:end, (i - 1) * (length(tel_file_name) + 1) + 1 + j) = ...
            tel{j}.data(:, obs_id(i));
        
    end
    
end

