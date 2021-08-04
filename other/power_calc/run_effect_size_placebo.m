
addpath('fcts/')

% Drugs
load('../../figures/NADA/data_for_figs/drug_code.mat') 
idx_plc = find(drug_code(:,2)==0); % 0: placebo

% EV
load('../../figures/NADA/data_for_figs/EV_SH_mat_all.mat')
load('../../figures/NADA/data_for_figs/EV_LH_mat_all.mat')

% IG
load('../../figures/NADA/data_for_figs/IG_SH.mat')
load('../../figures/NADA/data_for_figs/IG_LH.mat')

% Scores
load('../../figures/NADA/data_for_figs/first_LH.mat');
load('../../figures/NADA/data_for_figs/score_SH.mat');
load('../../figures/NADA/data_for_figs/score_LH.mat');

% High value bandit
load('../../figures/NADA/data_for_figs/high_value_SH.mat')
load('../../figures/NADA/data_for_figs/high_value_LH.mat')

% Low value bandit
load('../../figures/NADA/data_for_figs/low_value_SH.mat')
load('../../figures/NADA/data_for_figs/low_value_LH.mat')

% Novel bandit
load('../../figures/NADA/data_for_figs/novel_SH.mat')
load('../../figures/NADA/data_for_figs/novel_LH.mat')

% Model selection
load('../../figures/NADA/data_for_figs/models_desc.mat');
load('../../figures/NADA/data_for_figs/models_mean.mat');
load('../../figures/NADA/data_for_figs/models_std.mat');

% Epsilon
load('../../figures/NADA/data_for_figs/xi_SH.mat');
load('../../figures/NADA/data_for_figs/xi_LH.mat');

% Novelty bonus
load('../../figures/NADA/data_for_figs/nov_SH.mat');
load('../../figures/NADA/data_for_figs/nov_LH.mat');

% Effect size: 0.2 = small; 0.5 = medium; 0.8 = large
EF_EV = compute_ef(EV_SH_mat_all(idx_plc), EV_LH_mat_all(idx_plc));
EF_IG = compute_ef(IG_SH(idx_plc), IG_LH(idx_plc));
EF_score_first = compute_ef(score_SH(idx_plc), first_LH(idx_plc));
EF_score = compute_ef(score_SH(idx_plc), score_LH(idx_plc));
EF_high = compute_ef(high_value_SH(idx_plc), high_value_LH(idx_plc));
EF_low = compute_ef(low_value_SH(idx_plc), low_value_LH(idx_plc));
EF_novel = compute_ef(novel_SH(idx_plc), novel_LH(idx_plc));
EF_model_4th = compute_ef_m(models_mean(4),models_mean(7),models_std(4),models_std(7));
EF_epsilon = compute_ef(xi_SH, xi_LH);
EF_novbonus = compute_ef(nov_SH, nov_LH);

% Compute sample size for at least 95% power - t-tests
[n_sample_EV, pow_EV] = compute_sample_size(EV_SH_mat_all(idx_plc), EV_LH_mat_all(idx_plc));
[n_sample_IG, pow_IG] = compute_sample_size(IG_SH(idx_plc), IG_LH(idx_plc));
[n_sample_score_first, pow_score_first] = compute_sample_size(score_SH(idx_plc), first_LH(idx_plc));
[n_sample_score, pow_score] = compute_sample_size(score_SH(idx_plc), score_LH(idx_plc));
[n_sample_high, pow_high] = compute_sample_size(high_value_SH(idx_plc), high_value_LH(idx_plc));
[n_sample_low, pow_low] = compute_sample_size(low_value_SH(idx_plc), low_value_LH(idx_plc));
[n_sample_novel, pow_novel] = compute_sample_size(novel_SH(idx_plc), novel_LH(idx_plc));
[n_sample_model_4th, pow_model_4th] = compute_sample_size_m(models_mean(4),models_mean(7),models_std(4),models_std(7));
[n_sample_epsilon, pow_epsilon] = compute_sample_size(xi_SH, xi_LH);
[n_sample_novbonus, pow_novbonus] = compute_sample_size(nov_SH, nov_LH);




