
addpath('./fct/')

data_fold = ('../../../data/');
dir_ = (strcat(data_fold,'data_for_figs/'));

% For exclusion
load('../../usermat_completed.mat')

load('../../../data_analysis/6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Compute rows

% score SH
tmp = load(strcat(dir_, 'per_trial_score_SH.mat'));
[perTrial_score_SH, row_desc] = fct_compute_table_row_score(tmp.per_trial_score(:,2:end), to_del);

% score LH 1st
tmp = load(strcat(dir_, 'per_trial_score_LH_1st.mat'));
[perTrial_score_LH_1st, ~] = fct_compute_table_row_score(tmp.per_trial_score(:,2:end), to_del);

% score LH all
tmp = load(strcat(dir_, 'per_trial_score_LH_all.mat'));
[perTrial_score_LH_all, ~] = fct_compute_table_row_score(tmp.per_trial_score(:,2:end), to_del);

% freq A 
tmp = load(strcat(dir_, 'per_trial_freq_SH_A.mat'));
[perTrial_freqA_SH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_SH_A(:,2:end), to_del);
tmp = load(strcat(dir_, 'per_trial_freq_LH_A.mat'));
[perTrial_freqA_LH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_LH_A(:,2:end), to_del);

% freq B 
tmp = load(strcat(dir_, 'per_trial_freq_SH_B.mat'));
[perTrial_freqB_SH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_SH_B(:,2:end), to_del);
tmp = load(strcat(dir_, 'per_trial_freq_LH_B.mat'));
[perTrial_freqB_LH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_LH_B(:,2:end), to_del);

% freq C 
tmp = load(strcat(dir_, 'per_trial_freq_SH_C.mat'));
[perTrial_freqC_SH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_SH_C(:,2:end), to_del);
tmp = load(strcat(dir_, 'per_trial_freq_LH_C.mat'));
[perTrial_freqC_LH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_LH_C(:,2:end), to_del);

% freq D 
tmp = load(strcat(dir_, 'per_trial_freq_SH_D.mat'));
[perTrial_freqD_SH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_SH_D(:,2:end), to_del);
tmp = load(strcat(dir_, 'per_trial_freq_LH_D.mat'));
[perTrial_freqD_LH, ~] = fct_compute_table_row_freq(tmp.per_trial_freq_LH_D(:,2:end), to_del);

% freq H 
tmp = load(strcat(dir_, 'per_trial_exploreexploit_SH_H.mat'));
[perTrial_freqH_SH, ~] = fct_compute_table_row_freq(tmp.per_trial_exploreexploit_SH_H(:,2:end), to_del);
tmp = load(strcat(dir_, 'per_trial_exploreexploit_LH_H.mat'));
[perTrial_freqH_LH, ~] = fct_compute_table_row_freq(tmp.per_trial_exploreexploit_LH_H(:,2:end), to_del);

%high_freq_LH = [tmp.per_trial_exploreexploit_LH_H(:,1), tmp.per_trial_exploreexploit_LH_H(:,end)];

% freq M
tmp = load(strcat(dir_, 'per_trial_exploreexploit_SH_M.mat'));
[perTrial_freqM_SH, ~] = fct_compute_table_row_freq(tmp.per_trial_exploreexploit_SH_M(:,2:end), to_del);
tmp = load(strcat(dir_, 'per_trial_exploreexploit_LH_M.mat'));
[perTrial_freqM_LH, ~] = fct_compute_table_row_freq(tmp.per_trial_exploreexploit_LH_M(:,2:end), to_del);

% freq diffAB
tmp1 = load(strcat(dir_, 'per_trial_freq_SH_A.mat'));
tmp2 = load(strcat(dir_, 'per_trial_freq_SH_B.mat'));
freq_SH = tmp1.per_trial_freq_SH_A(:,2:end)-tmp2.per_trial_freq_SH_B(:,2:end);
[perTrial_freqdiffAB_SH, ~] = fct_compute_table_row_freq(freq_SH, to_del);

tmp1 = load(strcat(dir_, 'per_trial_freq_LH_A.mat'));
tmp2 = load(strcat(dir_, 'per_trial_freq_LH_B.mat'));
freq_LH = tmp1.per_trial_freq_LH_A(:,2:end)-tmp2.per_trial_freq_LH_B(:,2:end);
[perTrial_freqdiffAB_LH, ~] = fct_compute_table_row_freq(freq_LH, to_del);

[perTrial_freqdiffAB_both, ~] = fct_compute_table_row_freq((freq_SH+freq_LH)/2, to_del);


% freq diff31
tmp1 = load(strcat(dir_, 'per_trial_freq_SH_A.mat'));
tmp2 = load(strcat(dir_, 'per_trial_freq_SH_B.mat'));
tmp3 = load(strcat(dir_, 'per_trial_freq_SH_D.mat'));
freq_SH = tmp1.per_trial_freq_SH_A(:,2:end) - (tmp2.per_trial_freq_SH_B(:,2:end)+tmp3.per_trial_freq_SH_D(:,2:end));
[perTrial_freqdiff13_SH, ~] = fct_compute_table_row_freq(freq_SH, to_del);
tmp1 = load(strcat(dir_, 'per_trial_freq_LH_A.mat'));
tmp2 = load(strcat(dir_, 'per_trial_freq_LH_B.mat'));
tmp3 = load(strcat(dir_, 'per_trial_freq_LH_D.mat'));
freq_LH = tmp1.per_trial_freq_LH_A(:,2:end) - (tmp2.per_trial_freq_LH_B(:,2:end)+tmp3.per_trial_freq_LH_D(:,2:end));
[perTrial_freqdiff13_LH, ~] = fct_compute_table_row_freq(freq_LH, to_del);

[perTrial_freqdiff13_both, ~] = fct_compute_table_row_freq((freq_SH+freq_LH)/2, to_del);

% Table

T = table(perTrial_score_SH, perTrial_score_LH_1st, perTrial_score_LH_all, ...
                perTrial_freqA_SH, perTrial_freqA_LH, ...
                perTrial_freqB_SH, perTrial_freqB_LH, ...
                perTrial_freqC_SH, perTrial_freqC_LH, ...
                perTrial_freqD_SH, perTrial_freqD_LH, ...
                perTrial_freqH_SH, perTrial_freqH_LH, ...
                perTrial_freqM_SH, perTrial_freqM_LH, ...
                perTrial_freqdiffAB_SH, perTrial_freqdiffAB_LH, ...
                perTrial_freqdiff13_SH, perTrial_freqdiff13_LH, ...
                perTrial_freqdiffAB_both, perTrial_freqdiff13_both);
            
T.Properties.RowNames = row_desc;

Xc = table2cell(T);
Tnew = cell2table(Xc','RowNames',T.Properties.VariableNames,'VariableNames',T.Properties.RowNames);

Tnew

