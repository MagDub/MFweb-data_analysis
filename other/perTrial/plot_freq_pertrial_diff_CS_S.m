
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

[mean_SH_H, sem_SH_H, beta_SH_H] = compute_val(per_trial_freq_SH_A(:,2:end), n_part);
[mean_LH_H, sem_LH_H, beta_LH_H] = compute_val(per_trial_freq_LH_A(:,2:end), n_part);

[mean_SH_M, sem_SH_M, beta_SH_M] = compute_val(per_trial_freq_SH_B(:,2:end), n_part);
[mean_LH_M, sem_LH_M, beta_LH_M] = compute_val(per_trial_freq_SH_B(:,2:end), n_part);

[mean_SH_H_min_M, sem_SH_H_min_M, beta_SH_H_min_M] = compute_val(per_trial_freq_SH_A(:,2:end)-per_trial_freq_SH_B(:,2:end), n_part);
[mean_LH_H_min_M, sem_LH_H_min_M, beta_LH_H_min_M] = compute_val(per_trial_freq_LH_A(:,2:end)-per_trial_freq_LH_B(:,2:end), n_part);



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
fct_plot_freq(n_trials, mean_SH_H, beta_SH_H, {'Short horizon','CS'}, 'a', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,2)
ylim_ = [10 50];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_M, beta_SH_M, {'Short horizon','S'}, 'b', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,3)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.62;
fct_plot_freq(n_trials, mean_SH_H_min_M, beta_SH_H_min_M, {'Short horizon','CS - S'}, 'c', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,4)
ylim_ = [20 50];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_H, beta_LH_H, {'Long horizon','CS'}, 'd', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,5)
ylim_ = [10 50];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_M, beta_LH_M, {'Long horizon','S'}, 'e', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,3,6)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.62;
fct_plot_freq(n_trials, mean_LH_H_min_M, beta_LH_H_min_M, {'Long horizon','CS - S'}, 'f', 'NorthWest', ylim_, index_, height_stats_)

% Export
addpath('../../../export_fig')
export_fig(['./fig/Fig_per_trial_freq_diff_CS_S.tif'],'-nocrop','-r200')

