
addpath('fcts/')

load('../../usermat_completed.mat')
numel = size(usermat_completed,2);

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

% EV
load('../../../data/data_for_figs/EV_SH_mat.mat')
load('../../../data/data_for_figs/EV_LH_mat.mat')

% Remove ID
EV_SH_mat(to_del,:) = [];
EV_LH_mat(to_del,:) = [];

% 
% % IG
% load('../../../data/data_for_figs/IS_SH_mat.mat')
% load('../../../data/data_for_figs/IS_LH_mat.mat')
% 
% % Remove ID
% IS_SH_mat(to_del,:) = [];
% IS_LH_mat(to_del,:) = [];
% 
% 
% % Scores
% load('../../../data/data_for_figs/first_LH.mat');
% load('../../../data/data_for_figs/score_SH.mat');
% load('../../../data/data_for_figs/score_LH.mat');
% 
% % Remove ID
% first_LH(to_del,:) = [];
% score_SH(to_del,:) = [];
% score_LH(to_del,:) = [];
% 
% 
% % High value bandit
% load('../../../data/data_for_figs/pickedhigh_SH.mat')
% load('../../../data/data_for_figs/pickedhigh_LH.mat')
% 
% % Remove ID
% pickedhigh_SH(to_del,:) = [];
% pickedhigh_LH(to_del,:) = [];
% 
% % Low value bandit
% load('../../../data/data_for_figs/pickedD_SH.mat')
% load('../../../data/data_for_figs/pickedD_LH.mat')
% 
% % Remove ID
% pickedD_SH(to_del,:) = [];
% pickedD_LH(to_del,:) = [];
% 
% % Novel bandit
% load('../../../data/data_for_figs/pickedC_SH.mat')
% load('../../../data/data_for_figs/pickedC_LH.mat')
% 
% % Remove ID
% pickedC_SH(to_del,:) = [];
% pickedC_LH(to_del,:) = [];
 
% % Model selection
% load('../../7_crossval/mean_all_pp.mat') % 4: thomp+xi+nv vs 11:hybrid+nov
% mod_1st = mean_all_pp(:,4);
% mod_4th = mean_all_pp(:,11);

load('../../../data/data_for_figs/mle_mat_all.mat');
BIC_all = 2*mle_mat_all + log(400).*[3, 5, 5, 7,    4, 6, 6, 8,     8, 10, 10, 12]; %mle is NLL
BIC_all(to_del,:) = [];
mod_thomp=BIC_all(:,1);
mod_thomp_heu=BIC_all(:,4);
 
% % Remove ID
% mod_1st(to_del,:) = [];
% mod_4th(to_del,:) = [];
% 
% % Epsilon
% load('../../../data/data_for_figs/mod12_xi_SH.mat');
% load('../../../data/data_for_figs/mod12_xi_LH.mat');
% 
% % Remove ID
% xi_SH(to_del,:) = [];
% xi_LH(to_del,:) = [];
% 
% 
% % Novelty bonus
% load('../../../data/data_for_figs/mod12_eta_SH.mat');
% load('../../../data/data_for_figs/mod12_eta_LH.mat');
% 
% % Remove ID
% eta_SH(to_del,:) = [];
% eta_LH(to_del,:) = [];
% 
% % Uncertainty
% load('../../../data/data_for_figs/mod12_sgm0_SH.mat');
% load('../../../data/data_for_figs/mod12_sgm0_LH.mat');
% 
% % Remove ID
% sgm0_SH(to_del,:) = [];
% sgm0_LH(to_del,:) = [];

% Effect size: 0.2 = small; 0.5 = medium; 0.8 = large
%EF_EV = compute_ef_paired(EV_SH_mat, EV_LH_mat);
% EF_IG = compute_ef_paired(IS_SH_mat, IS_LH_mat);
% EF_score_first = compute_ef_paired(score_SH, first_LH);
% EF_score = compute_ef_paired(score_SH, score_LH);
% EF_high = compute_ef_paired(pickedhigh_SH, pickedhigh_LH);
% EF_low = compute_ef_paired(pickedD_SH, pickedD_LH);
% EF_novel = compute_ef_paired(pickedC_SH, pickedC_LH);
% EF_epsilon = compute_ef_paired(xi_SH, xi_LH);
% EF_novbonus = compute_ef_paired(eta_SH, eta_LH);
% EF_sgm0 = compute_ef_paired(sgm0_SH, sgm0_LH);
EF_mod = compute_ef_paired(mod_thomp_heu, mod_thomp);

% Compute sample size for at least 95% power - t-tests
%[n_sample_EV, pow_EV] = compute_sample_size_paired(EV_SH_mat-EV_LH_mat);
% [n_sample_IG, pow_IG] = compute_sample_size_paired(IS_SH_mat-IS_LH_mat);
% [n_sample_score_first, pow_score_first] = compute_sample_size_paired(score_SH-first_LH);
% [n_sample_score, pow_score] = compute_sample_size_paired(score_SH-score_LH);
% [n_sample_high, pow_high] = compute_sample_size_paired(pickedhigh_SH-pickedhigh_LH);
% [n_sample_low, pow_low] = compute_sample_size_paired(pickedD_SH-pickedD_LH);
% [n_sample_novel, pow_novel] = compute_sample_size_paired(pickedC_SH-pickedC_LH);
% [n_sample_epsilon, pow_epsilon] = compute_sample_size_paired(xi_SH-xi_LH);
% [n_sample_novbonus, pow_novbonus] = compute_sample_size_paired(eta_SH-eta_LH);
% [n_sample_sgm0, pow_sgm0] = compute_sample_size_paired(sgm0_SH-sgm0_LH);
[n_sample_mod, pow_mod] = compute_sample_size_paired(mod_thomp_heu-mod_thomp);


% % Do subjects explore more in the long horizon?
% summary_H1 = [EF_high, EF_low, EF_novel, EF_IG, EF_EV; ...
%     n_sample_high, n_sample_low, n_sample_novel, n_sample_IG, n_sample_EV]';
% 
% % Is exploration beneficial for subjects?
% summary_H2 = [EF_score_first, EF_score; ...
%     n_sample_score_first, n_sample_score]';
% 
% % Do subjects use exploration heurisitcs?
% summary_H3 = [EF_epsilon, EF_novbonus, EF_sgm0; ...
%     n_sample_epsilon, n_sample_novbonus, n_sample_sgm0]';



