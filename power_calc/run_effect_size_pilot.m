
addpath('fcts/')

% EV
load('../../data/data_for_figs/EV_SH_mat.mat')
load('../../data/data_for_figs/EV_LH_mat.mat')

% Remove ID
EV_SH_mat([4, 32, 36],:) = [];
EV_LH_mat([4, 32, 36],:) = [];


% IG
load('../../data/data_for_figs/IS_SH_mat.mat')
load('../../data/data_for_figs/IS_LH_mat.mat')

% Remove ID
IS_SH_mat([4, 32, 36],:) = [];
IS_LH_mat([4, 32, 36],:) = [];


% Scores
load('../../data/data_for_figs/first_LH.mat');
load('../../data/data_for_figs/score_SH.mat');
load('../../data/data_for_figs/score_LH.mat');

% Remove ID
first_LH([4, 32, 36],:) = [];
score_SH([4, 32, 36],:) = [];
score_LH([4, 32, 36],:) = [];


% High value bandit
load('../../data/data_for_figs/pickedhigh_SH.mat')
load('../../data/data_for_figs/pickedhigh_LH.mat')

% Remove ID
pickedhigh_SH([4, 32, 36],:) = [];
pickedhigh_LH([4, 32, 36],:) = [];

% Low value bandit
load('../../data/data_for_figs/pickedD_SH.mat')
load('../../data/data_for_figs/pickedD_LH.mat')

% Remove ID
pickedD_SH([4, 32, 36],:) = [];
pickedD_LH([4, 32, 36],:) = [];

% Novel bandit
load('../../data/data_for_figs/pickedC_SH.mat')
load('../../data/data_for_figs/pickedC_LH.mat')

% Remove ID
pickedC_SH([4, 32, 36],:) = [];
pickedC_LH([4, 32, 36],:) = [];

% Model selection
load('../7_crossval/mean_all_pp.mat') % 4: thomp+xi+nv vs 11:hybrid+nov
mod_1st = mean_all_pp(:,4);
mod_4th = mean_all_pp(:,11);

% Remove ID
mod_1st([4, 32, 36],:) = [];
mod_4th([4, 32, 36],:) = [];

% Epsilon
load('../../data/data_for_figs/xi_SH.mat');
load('../../data/data_for_figs/xi_LH.mat');

% Remove ID
xi_SH([4, 32, 36],:) = [];
xi_LH([4, 32, 36],:) = [];


% Novelty bonus
load('../../data/data_for_figs/eta_SH.mat');
load('../../data/data_for_figs/eta_LH.mat');

% Remove ID
eta_SH([4, 32, 36],:) = [];
eta_LH([4, 32, 36],:) = [];

% Uncertainty
load('../../data/data_for_figs/sgm0_SH.mat');
load('../../data/data_for_figs/sgm0_LH.mat');

% Remove ID
sgm0_SH([4, 32, 36],:) = [];
sgm0_LH([4, 32, 36],:) = [];

% Effect size: 0.2 = small; 0.5 = medium; 0.8 = large
EF_EV = compute_ef_paired(EV_SH_mat, EV_LH_mat);
EF_IG = compute_ef_paired(IS_SH_mat, IS_LH_mat);
EF_score_first = compute_ef_paired(score_SH, first_LH);
EF_score = compute_ef_paired(score_SH, score_LH);
EF_high = compute_ef_paired(pickedhigh_SH, pickedhigh_LH);
EF_low = compute_ef_paired(pickedD_SH, pickedD_LH);
EF_novel = compute_ef_paired(pickedC_SH, pickedC_LH);
EF_epsilon = compute_ef_paired(xi_SH, xi_LH);
EF_novbonus = compute_ef_paired(eta_SH, eta_LH);
EF_sgm0 = compute_ef_paired(sgm0_SH, sgm0_LH);
EF_mod = compute_ef_paired(mod_1st, mod_4th);

% Compute sample size for at least 95% power - t-tests
[n_sample_EV, pow_EV] = compute_sample_size_paired(EV_SH_mat-EV_LH_mat);
[n_sample_IG, pow_IG] = compute_sample_size_paired(IS_SH_mat-IS_LH_mat);
[n_sample_score_first, pow_score_first] = compute_sample_size_paired(score_SH-first_LH);
[n_sample_score, pow_score] = compute_sample_size_paired(score_SH-score_LH);
[n_sample_high, pow_high] = compute_sample_size_paired(pickedhigh_SH-pickedhigh_LH);
[n_sample_low, pow_low] = compute_sample_size_paired(pickedD_SH-pickedD_LH);
[n_sample_novel, pow_novel] = compute_sample_size_paired(pickedC_SH-pickedC_LH);
[n_sample_epsilon, pow_epsilon] = compute_sample_size_paired(xi_SH-xi_LH);
[n_sample_novbonus, pow_novbonus] = compute_sample_size_paired(eta_SH-eta_LH);
[n_sample_sgm0, pow_sgm0] = compute_sample_size_paired(sgm0_SH-sgm0_LH);
[n_sample_mod, pow_mod] = compute_sample_size_paired(mod_1st-mod_4th);


% Do subjects explore more in the long horizon?
summary_H1 = [EF_high, EF_low, EF_novel, EF_IG, EF_EV; ...
    n_sample_high, n_sample_low, n_sample_novel, n_sample_IG, n_sample_EV]';

% Is exploration beneficial for subjects?
summary_H2 = [EF_score_first, EF_score; ...
    n_sample_score_first, n_sample_score]';

% Do subjects use exploration heurisitcs?
summary_H3 = [EF_epsilon, EF_novbonus, EF_sgm0; ...
    n_sample_epsilon, n_sample_novbonus, n_sample_sgm0]';



