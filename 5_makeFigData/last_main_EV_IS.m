addpath('./functions/')
load('../usermat.mat')
data_fold = ('../../data/');
numel = size(usermat,2);

% scripts
[EV_SH_mat, EV_LH_mat] = compute_EV_all(usermat, data_fold); % expected values
[IS_SH_mat, IS_LH_mat] = compute_information_seeking(data_fold); % information seeking

save(strcat(data_fold, 'data_for_figs/EV_SH_mat.mat'), 'EV_SH_mat')
save(strcat(data_fold, 'data_for_figs/EV_LH_mat.mat'), 'EV_LH_mat')
save(strcat(data_fold, 'data_for_figs/IS_SH_mat.mat'), 'IS_SH_mat')
save(strcat(data_fold, 'data_for_figs/IS_LH_mat.mat'), 'IS_LH_mat')