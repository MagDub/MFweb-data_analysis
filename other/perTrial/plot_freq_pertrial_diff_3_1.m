
addpath('./fct/')

data_fold = ('../../../data/');
dir_ = (strcat(data_fold,'data_for_figs/'));

%%% Load data

load('../../usermat_completed.mat')

load(strcat(dir_, 'per_trial_freq_SH_A.mat'));
load(strcat(dir_, 'per_trial_freq_LH_A.mat'));
load(strcat(dir_, 'per_trial_freq_SH_B.mat'));
load(strcat(dir_, 'per_trial_freq_LH_B.mat'));

load(strcat(dir_, 'per_trial_exploreexploit_SH_H.mat'));
load(strcat(dir_, 'per_trial_exploreexploit_LH_H.mat'));
load(strcat(dir_, 'per_trial_exploreexploit_SH_M.mat'));
load(strcat(dir_, 'per_trial_exploreexploit_LH_M.mat'));

load(strcat(dir_, 'per_trial_freq_SH_C.mat'));
load(strcat(dir_, 'per_trial_freq_LH_C.mat'));
load(strcat(dir_, 'per_trial_freq_SH_D.mat'));
load(strcat(dir_, 'per_trial_freq_LH_D.mat'));

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

per_trial_freq_SH_A(to_del,:) = nan;
per_trial_freq_LH_A(to_del,:) = nan;
per_trial_freq_SH_B(to_del,:) = nan;
per_trial_freq_LH_B(to_del,:) = nan;

per_trial_exploreexploit_SH_H(to_del,:) = nan;
per_trial_exploreexploit_LH_H(to_del,:) = nan;
per_trial_exploreexploit_SH_M(to_del,:) = nan;
per_trial_exploreexploit_LH_M(to_del,:) = nan;

per_trial_freq_SH_C(to_del,:) = nan;
per_trial_freq_LH_C(to_del,:) = nan;
per_trial_freq_SH_D(to_del,:) = nan;
per_trial_freq_LH_D(to_del,:) = nan;


%%% Concat

n_part = size(per_trial_freq_SH_A,1)-size(to_del,2);
n_trials = size(per_trial_freq_SH_A(:,2:end),2);

[mean_SH_A, sem_SH_A, beta_SH_A] = compute_val(per_trial_freq_SH_A(:,2:end), n_part);
[mean_LH_A, sem_LH_A, beta_LH_A] = compute_val(per_trial_freq_LH_A(:,2:end), n_part);

[mean_SH_BD, sem_SH_BD, beta_SH_BD] = compute_val(per_trial_freq_SH_B(:,2:end)+per_trial_freq_SH_D(:,2:end), n_part);
[mean_LH_BD, sem_LH_BD, beta_LH_BD] = compute_val(per_trial_freq_LH_B(:,2:end)+per_trial_freq_LH_D(:,2:end), n_part);

[mean_SH_3_min_1, sem_SH_3_min_1, beta_SH_3_min_1] = compute_val(per_trial_freq_SH_A(:,2:end)-...
                                                        (per_trial_freq_SH_B(:,2:end)+per_trial_freq_SH_D(:,2:end)), n_part);
[mean_LH_3_min_1, sem_LH_3_min_1, beta_LH_3_min_1] = compute_val(per_trial_freq_LH_A(:,2:end)-...
                                                        (per_trial_freq_LH_B(:,2:end)+per_trial_freq_LH_D(:,2:end)), n_part);


%%% Plot

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on

subplot(2,3,1)
ylim_ = [20 50];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_A, beta_SH_A, {'Short horizon','CS'}, 'a', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,2)
ylim_ = [10 50];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_BD, beta_SH_BD, {'Short horizon','S&D'}, 'b', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,3)
ylim_ = [0 30];
index_ = 10;
height_stats_ = 0.62;
fct_plot_freq(n_trials, mean_SH_3_min_1, beta_SH_3_min_1, {'Short horizon','CS - S&D'}, 'c', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,4)
ylim_ = [20 50];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_A, beta_LH_A, {'Long horizon','CS'}, 'd', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,5)
ylim_ = [10 50];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_BD, beta_LH_BD, {'Long horizon','S&D'}, 'e', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,6)
ylim_ = [0 30];
index_ = 10;
height_stats_ = 0.62;
fct_plot_freq(n_trials, mean_LH_3_min_1, beta_LH_3_min_1, {'Long horizon','CS - S&D'}, 'f', 'NorthWest', ylim_, index_, height_stats_)

% % Export
% addpath('../../../export_fig')
% export_fig(['./fig/Fig_per_trial_freq_diff_3_1.tif'],'-nocrop','-r200')
