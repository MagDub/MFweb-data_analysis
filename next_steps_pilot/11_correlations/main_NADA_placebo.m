close all;
clear;

% Load ADHD questionnaire data
[ASRS_all, ASRS_score_desc] = concat_ASRS_NADA();

% Load epsilon values
data_NADA=load('/Users/magdadubois/MF/figures/NADA/data_for_figs/model_parameters_Q0uni.mat');
param_SH = data_NADA.model_parameters_Q0uni(:,4);
param_LH = data_NADA.model_parameters_Q0uni(:,5);

% NADA Drugs
load('/Users/magdadubois/MF/figures/NADA/data_for_figs/drug_code.mat') %0: placebo, 1:amisulpride, 2:propranolol
idx_plc = find(drug_code(:,2)==0);
idx_ami = find(drug_code(:,2)==1);
idx_prop = find(drug_code(:,2)==2);

% Take only placebo
ASRS_all = ASRS_all(idx_plc,:);
param_SH = param_SH(idx_plc,:);
param_LH = param_LH(idx_plc,:);
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

ASRS_score_desc_legend = {'Sum of all items','Nb of items shaded', 'Sum of items in Part A', ...
                            'Nb of Part A items shaded', 'ADHD threshold reached', ...
                            'Sum of Inattention items', 'Sum of HyperImpul items', ...
                            'Nb of Inattention items shaded', 'Nb of HyperImpuly items shaded'};

all_col = [1, 3, 5, 6, 7, 9];

for n_ = 1:size(all_col,2)

    ind_col = all_col(n_);

    subplot(2,3,n_)
    plot(param_SH, (rand(20,1)-0.5)/5+ASRS_all(:,ind_col), 'o')
    ylim([min(ASRS_all(:,ind_col))-0.5,max(ASRS_all(:,ind_col))+0.5])
    title(strcat('r=', num2str(round(cor_mat_SH_xi(1,ind_col),3)), 32, 32, 'p=', num2str(round(cor_mat_SH_xi(2,ind_col),3))));
    legend boxoff 
    legend boxoff;
    %disp(ASRS_score_desc(:,ind_col));
    ylabel(ASRS_score_desc_legend(:,ind_col))
    %ylabel('ASRS ADHD threshold passed')
    xlabel('\epsilon short horizon')

end

addpath('../../figures/export_fig')
export_fig(['Fig/Fig_corr_ASRS_xiSH.tif'],'-nocrop','-r200')
