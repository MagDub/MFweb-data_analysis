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

%%%% Moving average window

window_ = 1;
    
%%% Concat

n_part = size(per_trial_freq_SH_A,1)-size(to_del,2);
n_trials = size(per_trial_freq_SH_A(:,2:end),2);

[mean_SH_A, sem_SH_A, beta_SH_A] = compute_val_mov_av(per_trial_freq_SH_A(:,2:end), n_part, window_);
[mean_LH_A, sem_LH_A, beta_LH_A] = compute_val_mov_av(per_trial_freq_LH_A(:,2:end), n_part, window_);

[mean_SH_B, sem_SH_B, beta_SH_B] = compute_val_mov_av(per_trial_freq_SH_B(:,2:end), n_part, window_);
[mean_LH_B, sem_LH_B, beta_LH_B] = compute_val_mov_av(per_trial_freq_LH_B(:,2:end), n_part, window_);

[mean_SH_C, sem_SH_C, beta_SH_C] = compute_val_mov_av(per_trial_freq_SH_C(:,2:end), n_part, window_);
[mean_LH_C, sem_LH_C, beta_LH_C] = compute_val_mov_av(per_trial_freq_LH_C(:,2:end), n_part, window_);

[mean_SH_D, sem_SH_D, beta_SH_D] = compute_val_mov_av(per_trial_freq_SH_D(:,2:end), n_part, window_);
[mean_LH_D, sem_LH_D, beta_LH_D] = compute_val_mov_av(per_trial_freq_LH_D(:,2:end), n_part, window_);

[mean_SH_M, sem_SH_M, beta_SH_M] = compute_val_mov_av(per_trial_exploreexploit_SH_M(:,2:end), n_part, window_);
[mean_LH_M, sem_LH_M, beta_LH_M] = compute_val_mov_av(per_trial_exploreexploit_LH_M(:,2:end), n_part, window_);

[mean_SH_H, sem_SH_H, beta_SH_H] = compute_val_mov_av(per_trial_exploreexploit_SH_H(:,2:end), n_part, window_);
[mean_LH_H, sem_LH_H, beta_LH_H] = compute_val_mov_av(per_trial_exploreexploit_LH_H(:,2:end), n_part, window_);

[mean_SH_BD, sem_SH_BD, beta_SH_BD] = compute_val_mov_av(per_trial_freq_SH_B(:,2:end)+per_trial_freq_SH_D(:,2:end), n_part, window_);
[mean_LH_BD, sem_LH_BD, beta_LH_BD] = compute_val_mov_av(per_trial_freq_LH_B(:,2:end)+per_trial_freq_LH_D(:,2:end), n_part, window_);


%%% Plot

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 60 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on

subplot(2,6,1)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_A, beta_SH_A, {'Short horizon','certain standard (A)'}, 'a', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,2)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_B, beta_SH_B, {'Short horizon','standard (B)'}, 'b', 'NorthWest', ylim_, index_, height_stats_)
 
subplot(2,6,3)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_C, beta_SH_C, {'Short horizon','novel (C)'}, 'c', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,4)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.5;
fct_plot_freq(n_trials, mean_SH_D, beta_SH_D, {'Short horizon','low-value (D)'}, 'd', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,5)
ylim_ = [30 100];
index_ = 20;
height_stats_ = 0.62;
fct_plot_freq(n_trials, mean_SH_H, beta_SH_H, {'Short horizon','high-value (A or B)'}, 'e', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,6)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_SH_BD, beta_SH_BD, {'Short horizon','1-sample (B and D)'}, 'f', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,7)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_A, beta_LH_A, {'Long horizon','certain standard (A)'}, 'g', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,8)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_B, beta_LH_B, {'Long horizon','standard (B)'}, 'h', 'NorthWest', ylim_, index_, height_stats_)
 
subplot(2,6,9)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_C, beta_LH_C, {'Long horizon','novel (C)'}, 'i', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,10)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.5;
fct_plot_freq(n_trials, mean_LH_D, beta_LH_D, {'Long horizon','low-value (D)'}, 'j', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,11)
ylim_ = [30 100];
index_ = 20;
height_stats_ = 0.62;
fct_plot_freq(n_trials, mean_LH_H, beta_LH_H, {'Long horizon','high-value (A or B)'}, 'k', 'NorthWest', ylim_, index_, height_stats_)

subplot(2,6,12)
ylim_ = [0 70];
index_ = 20;
height_stats_ = 0.25;
fct_plot_freq(n_trials, mean_LH_BD, beta_LH_BD, {'Long horizon','1-sample (B and D)'}, 'l', 'NorthWest', ylim_, index_, height_stats_)
 
% Export
addpath('../../../export_fig')
export_fig(strcat('./fig/Fig_per_trial_freq_mov_av_',num2str(window_),'.tif'),'-nocrop','-r200')

