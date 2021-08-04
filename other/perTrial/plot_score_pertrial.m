
addpath('./fct/')

data_fold = ('../../../data/');
dir_ = (strcat(data_fold,'data_for_figs/'));

%%% Load data

load('../../usermat_completed.mat')

LH_all_desc = load(strcat(dir_, 'per_trial_score_LH_all_desc.mat'));
LH_all = load(strcat(dir_, 'per_trial_score_LH_all.mat'));

LH_1st_desc = load(strcat(dir_, 'per_trial_score_LH_1st_desc.mat'));
LH_1st = load(strcat(dir_, 'per_trial_score_LH_1st.mat'));

SH_desc = load(strcat(dir_, 'per_trial_score_SH_desc.mat'));
SH = load(strcat(dir_, 'per_trial_score_SH.mat'));

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
LH_all.per_trial_score(to_del,:) = nan;
LH_1st.per_trial_score(to_del,:) = nan;
SH.per_trial_score(to_del,:) = nan;


%%% Concat

n_part = size(LH_all.per_trial_score,1)-size(to_del,2);
n_trials = size(LH_all.per_trial_score(:,2:end),2);

mean_LH_all = nanmean(LH_all.per_trial_score(:,2:end),1);
sem_LH_all = nanstd(LH_all.per_trial_score(:,2:end),1)/sqrt(n_part);
beta_LH_all = fct_compute_coeff(LH_all.per_trial_score(:,2:end), n_trials);

mean_LH_1st = nanmean(LH_1st.per_trial_score(:,2:end),1);
sem_LH_1st = nanstd(LH_1st.per_trial_score(:,2:end),1)/sqrt(n_part);
beta_LH_1st = fct_compute_coeff(LH_1st.per_trial_score(:,2:end), n_trials);

mean_SH = nanmean(SH.per_trial_score(:,2:end),1);
sem_SH = nanstd(SH.per_trial_score(:,2:end),1)/sqrt(n_part);
beta_SH = fct_compute_coeff(SH.per_trial_score(:,2:end), n_trials);


%%% Plot

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

subplot(1,3,1)
fct_plot_score(n_trials, mean_SH, beta_SH, {'Short horizon','1st sample'}, 'a', 'NorthWest')

subplot(1,3,2)
fct_plot_score(n_trials, mean_LH_1st, beta_LH_1st, {'Long horizon','1st sample'}, 'b', 'NorthWest')

subplot(1,3,3)
fct_plot_score(n_trials, mean_LH_all, beta_LH_all, {'Long horizon','average sample'}, 'c', 'NorthWest')

% regression coeff

inter_SH = beta_SH(1,:)';
inter_LH_all = beta_LH_all(1,:)';
inter_LH_1st = beta_LH_1st(1,:)';

slope_SH = beta_SH(2,:)';
slope_LH_all = beta_LH_all(2,:)';
slope_LH_1st = beta_LH_1st(2,:)';

% Stats

[~,p,ci,stats] = ttest(slope_SH);
statSH = strcat('t(', num2str(stats.df), ')=', num2str(stats.tstat,3), ', p=', num2str(p,3), ', 95%CI=[', sprintf('%.2e', ci(1)), ',', sprintf('%.2e', ci(2)) ,']');

[~,p,ci,stats] = ttest(slope_LH_all);
statLH1st = strcat('t(', num2str(stats.df), ')=', num2str(stats.tstat,3), ', p=', num2str(p,3), ', 95%CI=[', sprintf('%.2e', ci(1)), ',', sprintf('%.2e', ci(2)) ,']');

[~,p,ci,stats] = ttest(slope_LH_1st);
statLHall = strcat('t(', num2str(stats.df), ')=', num2str(stats.tstat,3), ', p=', num2str(p,3), ', 95%CI=[', sprintf('%.2e', ci(1)), ',', sprintf('%.2e', ci(2)) ,']');


% Table

Measure = {'Score SH';'Score LH 1st';'Score LH all'};
Average = num2str([mean(mean_SH);mean(mean_LH_1st);mean(mean_LH_all)],4); 
Intercept = num2str([nanmean(inter_SH); nanmean(inter_LH_1st); nanmean(inter_LH_all)],4); 
Slope = {sprintf('%.2e',nanmean(slope_SH)), sprintf('%.2e',nanmean(slope_LH_1st)), sprintf('%.2e',nanmean(slope_LH_all))}';
Ttest = {statSH, statLH1st, statLHall}';

T = table(Measure,Average,Intercept,Slope, Ttest);

% % Export
% addpath('../../export_fig')
% export_fig(['./fig/Fig_per_trial_score.tif'],'-nocrop','-r200')

