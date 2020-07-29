
clear;

% Load ADHD questionnaire data
fol_all = '../../data/questionnaire/all';
load(strcat(fol_all,'/ASRS_all.mat'))
load(strcat(fol_all,'/ASRS_mat_desc.mat'))

% Load epsilon values
load('../../data/data_for_figs/model_parameters.mat')
load('../../data/data_for_figs/model_parameters_desc.mat')
ind_SH = find(contains(model_parameters_desc,'xi_short'));
ind_LH = find(contains(model_parameters_desc,'xi_long'));
param_SH = model_parameters(:,ind_SH);
param_LH = model_parameters(:,ind_LH);
param_mean = (param_SH+param_LH)/2;

% Correlations mean xi
r_mat = []; p_mat = []; signif_mat = [];
for i=1:size(ASRS_all,2)
    [rho, pval] = corr([ASRS_all(:,i),param_mean], 'rows','complete', 'Type','Pearson');
    r_mat(i) = rho(2,1);
    p_mat(i) = pval(2,1);
    signif_mat(i) = (pval(2,1)<0.05);
end
cor_mat_mean_xi = [r_mat; p_mat; signif_mat];

% Correlations LH xi
r_mat = []; p_mat = []; signif_mat = [];
for i=1:size(ASRS_all,2)
    [rho, pval] = corr([ASRS_all(:,i),param_LH], 'rows','complete', 'Type','Pearson');
    r_mat(i) = rho(2,1);
    p_mat(i) = pval(2,1);
    signif_mat(i) = (pval(2,1)<0.05);
end
cor_mat_LH_xi = [r_mat; p_mat; signif_mat];

% Correlations SH xi
r_mat = []; p_mat = []; signif_mat = [];
for i=1:size(ASRS_all,2)
    [rho, pval] = corr([ASRS_all(:,i),param_SH], 'rows','complete', 'Type','Pearson');
    r_mat(i) = rho(2,1);
    p_mat(i) = pval(2,1);
    signif_mat(i) = (pval(2,1)<0.05);
end
cor_mat_SH_xi = [r_mat; p_mat; signif_mat];

% cor_mat_mean_xi, cor_mat_LH_xi, cor_mat_SH_xi