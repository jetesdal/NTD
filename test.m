clear all
close all

% ------ %
% test 1 %
% ------ %

% load files
obs = 'data/test_1/wl_2013.mat';
tel{1} = 'data/test_1/ss_101_a_10.mat';
tel{2} = 'data/test_1/ss_101_b_10.mat';
tel{3} = 'data/test_1/ss_101_c_10.mat';
tel{4} = 'data/test_1/ss_101_d_10.mat';
tel{5} = 'data/test_1/ss_101_e_10.mat';
tel{6} = 'data/test_1/ss_104_f_10.mat';
tel{7} = 'data/test_1/ss_104_g_10.mat';
tel{8} = 'data/test_1/ss_104_h_10.mat';
tel{9} = 'data/test_1/ss_104_i_10.mat';

% selected period: from 1/7/2013 to 1/8/2013
time_start = datenum('01-Jul-2013');
time_stop  = datenum('01-Aug-2013');

