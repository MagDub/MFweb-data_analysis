
addpath('./fct/')

data_fold = ('../../../data/');
dir_ = (strcat(data_fold,'data_for_figs/'));

% For exclusion
to_del = [];
load('../../usermat_completed.mat')
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

%
tmp = load(strcat(dir_, 'per_trial_SH_all_HMCD.mat'));
data_ = tmp.per_trial_SH_all_HMCD(:,2:end);
[res_log_reg_SH_HMCD] = fct_log_reg(data_, to_del);

tmp = load(strcat(dir_, 'per_trial_LH_all_HMCD.mat'));
data_ = tmp.per_trial_LH_all_HMCD(:,2:end);
[res_log_reg_LH_HMCD] = fct_log_reg(data_, to_del);

%
tmp = load(strcat(dir_, 'per_trial_SH_all_ABCD.mat'));
data_ = tmp.per_trial_SH_all_ABCD(:,2:end);
[res_log_reg_SH_ABCD] = fct_log_reg(data_, to_del);

tmp = load(strcat(dir_, 'per_trial_LH_all_ABCD.mat'));
data_ = tmp.per_trial_LH_all_ABCD(:,2:end);
[res_log_reg_LH_ABCD] = fct_log_reg(data_, to_del);

% Table HMCD
[SH_HMCD, desc_HMCD] = fct_make_row_log(res_log_reg_SH_HMCD);
[LH_HMCD, ~] = fct_make_row_log(res_log_reg_LH_HMCD);

T = table(SH_HMCD, LH_HMCD);

T.Properties.RowNames = desc_HMCD;

Xc = table2cell(T);

T_HMCD = cell2table(Xc','RowNames',T.Properties.VariableNames,'VariableNames',T.Properties.RowNames);

% Table ABCD
[SH_ABCD, desc_ABCD] = fct_make_row_log(res_log_reg_SH_ABCD);
[LH_ABCD, ~] = fct_make_row_log(res_log_reg_LH_ABCD);

T = table(SH_ABCD, LH_ABCD);

T.Properties.RowNames = desc_ABCD;

Xc = table2cell(T);

T_ABCD = cell2table(Xc','RowNames',T.Properties.VariableNames,'VariableNames',T.Properties.RowNames);

T_HMCD
T_ABCD

