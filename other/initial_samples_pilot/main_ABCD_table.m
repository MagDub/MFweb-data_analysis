
%%% Initial samples

% Compute columns

[split_SH_ABC, split_SH_ABC_1, split_mat_SH_init_ABC, split_mat_SH_1_ABC, desc_split, SH_ABC, SH_ABC_1, N_AisH_mat_SH_ABC, N_BisH_mat_SH_ABC, N_ABisH_mat_SH_ABC] = make_col_SH('AB');
[LH_ABC, LH_ABC_1, LH_ABC_2, LH_ABC_3, LH_ABC_4, LH_ABC_5, LH_ABC_6, LH_ABC_26, ...
    split_LH_ABC, split_LH_ABC_1, split_LH_ABC_2, split_LH_ABC_3, split_LH_ABC_4, split_LH_ABC_5, split_LH_ABC_6, split_LH_ABC_26,...
    split_mat_LH_init_ABC, split_mat_LH_1_ABC, split_mat_LH_26_ABC, ~] = make_col_LH('AB');

[split_SH_ABD, split_SH_ABD_1, split_mat_SH_init_ABD, split_mat_SH_1_ABD, ~, SH_ABD, SH_ABD_1, N_AisH_mat_SH_ABD, N_BisH_mat_SH_ABD, N_ABisH_mat_SH_ABD] = make_col_SH('ABD');
[LH_ABD, LH_ABD_1, LH_ABD_2, LH_ABD_3, LH_ABD_4, LH_ABD_5, LH_ABD_6, LH_ABD_26, ...
    split_LH_ABD, split_LH_ABD_1, split_LH_ABD_2, split_LH_ABD_3, split_LH_ABD_4, split_LH_ABD_5, split_LH_ABD_6, split_LH_ABD_26,...
    split_mat_LH_init_ABD, split_mat_LH_1_ABD, split_mat_LH_26_ABD, ~] = make_col_LH('ABD');
 
[split_SH_ACD, split_SH_ACD_1, split_mat_SH_init_ACD, split_mat_SH_1_ACD, ~, SH_ACD, SH_ACD_1, N_AisH_mat_SH_ACD, N_BisH_mat_SH_ACD, N_ABisH_mat_SH_ACD] = make_col_SH('AD');
[LH_ACD, LH_ACD_1, LH_ACD_2, LH_ACD_3, LH_ACD_4, LH_ACD_5, LH_ACD_6, LH_ACD_26, ...
    split_LH_ACD, split_LH_ACD_1, split_LH_ACD_2, split_LH_ACD_3, split_LH_ACD_4, split_LH_ACD_5, split_LH_ACD_6, split_LH_ACD_26,...
    split_mat_LH_init_ACD, split_mat_LH_1_ACD, split_mat_LH_26_ACD, ~] = make_col_LH('AD');

[split_SH_BCD, split_SH_BCD_1, split_mat_SH_init_BCD, split_mat_SH_1_BCD, ~, SH_BCD, SH_BCD_1, N_AisH_mat_SH_BCD, N_BisH_mat_SH_BCD, N_ABisH_mat_SH_BCD] = make_col_SH('BD');
[LH_BCD, LH_BCD_1, LH_BCD_2, LH_BCD_3, LH_BCD_4, LH_BCD_5, LH_BCD_6, LH_BCD_26, ...
    split_LH_BCD, split_LH_BCD_1, split_LH_BCD_2, split_LH_BCD_3, split_LH_BCD_4, split_LH_BCD_5, split_LH_BCD_6, split_LH_BCD_26,...
    split_mat_LH_init_BCD, split_mat_LH_1_BCD, split_mat_LH_26_BCD, ~] = make_col_LH('BD');

% N
[freqAisH_ABC, freqBisH_ABC, freqABisH_ABC, stats_AvsB_ABC] = make_stats_N(N_AisH_mat_SH_ABC, N_BisH_mat_SH_ABC, N_ABisH_mat_SH_ABC);
[freqAisH_ABD, freqBisH_ABD, freqABisH_ABD, stats_AvsB_ABD] = make_stats_N(N_AisH_mat_SH_ABD, N_BisH_mat_SH_ABD, N_ABisH_mat_SH_ABD);


% Make table 
row_names = {'Certain_Standard', 'Standard', 'Novel', 'Low_Value'}';
 
T_init = table(SH_ABC, SH_ABD, SH_ACD, SH_BCD, 'RowNames', row_names, 'VariableNames', {'init_CS_S_N', 'init_CS_S_L', 'init_CS_N_L', 'init_S_N_L'});

T_1st_LH = table(LH_ABC_1, LH_ABD_1, LH_ACD_1, LH_BCD_1, 'RowNames', row_names, 'VariableNames', {'LH_1st_CS_S_N', 'LH_1st_CS_S_L', 'LH_1st_CS_N_L', 'LH_1st_S_N_L'});
 
T_1st_SH = table(SH_ABC_1, SH_ABD_1, SH_ACD_1, SH_BCD_1, 'RowNames', row_names, 'VariableNames', {'SH_1st_CS_S_N', 'SH_1st_CS_S_L', 'SH_1st_CS_N_L', 'SH_1st_S_N_L'});
 
T_26_LH = table(LH_ABC_26, LH_ABD_26, LH_ACD_26, LH_BCD_26, 'RowNames', row_names, 'VariableNames', {'LH_26_CS_S_N', 'LH_26_CS_S_L', 'LH_26_CS_N_L', 'LH_26_S_N_L'});

% Concatenate table
T = [T_init T_1st_SH T_1st_LH T_26_LH];

% Inverse
Ttmp = table2cell(T);
Tnew = cell2table(Ttmp','RowNames',T.Properties.VariableNames,'VariableNames',T.Properties.RowNames);

% % Export
% writetable(Tnew,'values_ABCD.xlsx');
