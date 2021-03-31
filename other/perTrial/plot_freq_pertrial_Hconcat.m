
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

% sum horizons
per_trial_freq_A = per_trial_freq_SH_A(:,2:end)+per_trial_freq_LH_A(:,2:end);
per_trial_freq_B = per_trial_freq_SH_B(:,2:end)+per_trial_freq_LH_B(:,2:end);
per_trial_freq_D = per_trial_freq_SH_D(:,2:end)+per_trial_freq_LH_D(:,2:end);

%%% Concat

n_part = size(per_trial_freq_D,1)-size(to_del,2);
n_trials = size(per_trial_freq_D,2);

[mean_D, sem_D, beta_D] = compute_val(per_trial_freq_D, n_part);



%%% Plot

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

subplot(1,3,1)
ylim_ = [0 20];
index_ = 10;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_D, beta_D, {'Low-value','bandit'}, 'a', 'NorthWest', ylim_, index_, height_stats_)


% % Export
% addpath('../../../export_fig')
% export_fig(['./fig/Fig_per_trial_freq_diff_3_1.tif'],'-nocrop','-r200')
