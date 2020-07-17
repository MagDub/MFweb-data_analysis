
addpath('fcts/')

% EV
load('../../data/data_for_figs/EV_SH_mat.mat')
load('../../data/data_for_figs/EV_LH_mat.mat')

% IG
load('../../data/data_for_figs/IS_SH_mat.mat')
load('../../data/data_for_figs/IS_LH_mat.mat')

% Scores
load('../../data/data_for_figs/first_LH.mat');
load('../../data/data_for_figs/score_SH.mat');
load('../../data/data_for_figs/score_LH.mat');

% High value bandit
load('../../data/data_for_figs/pickedhigh_SH.mat')
load('../../data/data_for_figs/pickedhigh_LH.mat')

% Low value bandit
load('../../data/data_for_figs/pickedD_SH.mat')
load('../../data/data_for_figs/pickedD_LH.mat')

% Novel bandit
load('../../data/data_for_figs/pickedC_SH.mat')
load('../../data/data_for_figs/pickedC_LH.mat')

% % Model selection
% load('../../figures/NADA/data_for_figs/models_desc.mat');
% load('../../figures/NADA/data_for_figs/models_mean.mat');
% load('../../figures/NADA/data_for_figs/models_std.mat');

% Effect size: 0.2 = small; 0.5 = medium; 0.8 = large
EF_EV = compute_ef(EV_SH_mat, EV_LH_mat);
EF_IG = compute_ef(IS_SH_mat, IS_LH_mat);
EF_score_first = compute_ef(score_SH, first_LH);
EF_score = compute_ef(score_SH, score_LH);
EF_high = compute_ef(pickedhigh_SH, pickedhigh_LH);
EF_low = compute_ef(pickedD_SH, pickedD_LH);
EF_novel = compute_ef(pickedC_SH, pickedC_LH);

% Compute sample size for at least 95% power - t-tests
%[n_sample_EV, pow_EV] = compute_sample_size(EV_SH_mat, EV_LH_mat);
[n_sample_IG, pow_IG] = compute_sample_size(IS_SH_mat, IS_LH_mat);
%[n_sample_score_first, pow_score_first] = compute_sample_size(score_SH, first_LH);
[n_sample_score, pow_score] = compute_sample_size(score_SH, score_LH);
[n_sample_high, pow_high] = compute_sample_size(pickedhigh_SH, pickedhigh_LH);
%[n_sample_low, pow_low] = compute_sample_size(pickedD_SH, pickedD_LH);
[n_sample_novel, pow_novel] = compute_sample_size(pickedC_SH, pickedC_LH);





