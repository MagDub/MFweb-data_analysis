
data_fold = ('../../data/');
dir_ = (strcat(data_fold,'data_for_figs/'));

% For exclusion
to_del = [];
load('../usermat_completed.mat')
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

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


% Table

T = table(perTrial_score_SH, perTrial_score_LH_1st, perTrial_score_LH_all, ...
                perTrial_freqA_SH, perTrial_freqA_LH, ...
                perTrial_freqB_SH, perTrial_freqB_LH, ...
                perTrial_freqC_SH, perTrial_freqC_LH, ...
                perTrial_freqD_SH, perTrial_freqD_LH, ...
                perTrial_freqH_SH, perTrial_freqH_LH, ...
                perTrial_freqM_SH, perTrial_freqM_LH);
            
T.Properties.RowNames = row_desc;

Xc = table2cell(T);
Tnew = cell2table(Xc','RowNames',T.Properties.VariableNames,'VariableNames',T.Properties.RowNames);

Tnew

