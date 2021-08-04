
clear;

% Load ADHD questionnaire data
[ASRS_all, ASRS_score_desc] = concat_ASRS_NADA();

% Load epsilon values
data_NADA=load('/Users/magdadubois/MF/figures/NADA/data_for_figs/model_parameters_Q0uni.mat');
param_SH = data_NADA.model_parameters_Q0uni(:,4);
param_LH = data_NADA.model_parameters_Q0uni(:,5);

% NADA Drugs
load('/Users/magdadubois/MF/figures/NADA/data_for_figs/drug_code.mat')

% For Excel 
exc_data_desc = {'Participant', 'Drug Code', 'xi_SH', 'xi_LH', 'Sum', 'ShadedNb',...
                    'SumA', 'ShadedNbA', 'PassThreshold', 'SumInattention', 'SumHyperImpuls', ...
                    'ShadedNbInattention', 'ShadedNbHyperImpuls'};

exc_data = [drug_code, param_SH, param_LH, ASRS_all];

% Remove 506
ASRS_all(6,1) = nan;
param_SH(6,1) = nan;
param_LH(6,1) = nan;
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

ASRS_score_desc(:,8);
cor_mat_LH_xi(:,8);