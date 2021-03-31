
%%% Initial samples

% Compute columns

[split_SH_ABC, split_SH_ABC_1, split_mat_SH_init_ABC, split_mat_SH_1_ABC, desc_split, SH_ABC, SH_ABC_1] = make_col_SH('AB');
[LH_ABC, LH_ABC_1, LH_ABC_2, LH_ABC_3, LH_ABC_4, LH_ABC_5, LH_ABC_6, LH_ABC_26, ...
    split_LH_ABC, split_LH_ABC_1, split_LH_ABC_2, split_LH_ABC_3, split_LH_ABC_4, split_LH_ABC_5, split_LH_ABC_6, split_LH_ABC_26,...
    split_mat_LH_init_ABC, split_mat_LH_1_ABC, split_mat_LH_26_ABC] = make_col_LH('AB');

[split_SH_ABD, split_SH_ABD_1, split_mat_SH_init_ABD, split_mat_SH_1_ABD, ~, SH_ABD, SH_ABD_1] = make_col_SH('ABD');
[LH_ABD, LH_ABD_1, LH_ABD_2, LH_ABD_3, LH_ABD_4, LH_ABD_5, LH_ABD_6, LH_ABD_26, ...
    split_LH_ABD, split_LH_ABD_1, split_LH_ABD_2, split_LH_ABD_3, split_LH_ABD_4, split_LH_ABD_5, split_LH_ABD_6, split_LH_ABD_26,...
    split_mat_LH_init_ABD, split_mat_LH_1_ABD, split_mat_LH_26_ABD] = make_col_LH('ABD');
 
[split_SH_ACD, split_SH_ACD_1, split_mat_SH_init_ACD, split_mat_SH_1_ACD, ~, SH_ACD, SH_ACD_1] = make_col_SH('AD');
[LH_ACD, LH_ACD_1, LH_ACD_2, LH_ACD_3, LH_ACD_4, LH_ACD_5, LH_ACD_6, LH_ACD_26, ...
    split_LH_ACD, split_LH_ACD_1, split_LH_ACD_2, split_LH_ACD_3, split_LH_ACD_4, split_LH_ACD_5, split_LH_ACD_6, split_LH_ACD_26,...
    split_mat_LH_init_ACD, split_mat_LH_1_ACD, split_mat_LH_26_ACD] = make_col_LH('AD');

[split_SH_BCD, split_SH_BCD_1, split_mat_SH_init_BCD, split_mat_SH_1_BCD, ~, SH_BCD, SH_BCD_1] = make_col_SH('BD');
[LH_BCD, LH_BCD_1, LH_BCD_2, LH_BCD_3, LH_BCD_4, LH_BCD_5, LH_BCD_6, LH_BCD_26, ...
    split_LH_BCD, split_LH_BCD_1, split_LH_BCD_2, split_LH_BCD_3, split_LH_BCD_4, split_LH_BCD_5, split_LH_BCD_6, split_LH_BCD_26,...
    split_mat_LH_init_BCD, split_mat_LH_1_BCD, split_mat_LH_26_BCD] = make_col_LH('BD');

% stats
[val_ABC_CS, val_ACD_CS, stats_ABC_ACD_CS] = make_stats_val(split_mat_SH_init_ABC(:,1), split_mat_SH_init_ACD(:,1));
[val_ABD_CS, val_ABD_CS, stats_ABC_ABD_CS] = make_stats_val(split_mat_SH_init_ABD(:,1), split_mat_SH_init_ACD(:,1));

[val_ABC_C, val_ACD_C, stats_ABC_ACD_C] = make_stats_val(split_mat_SH_init_ABC(:,2), split_mat_SH_init_BCD(:,2));
[val_ABD_C, val_ABD_C, stats_ABC_ABD_C] = make_stats_val(split_mat_SH_init_ABD(:,2), split_mat_SH_init_BCD(:,2));


% % save for figs
% save('./concat_data/desc_split.mat', 'desc_split')
% 
% save('./concat_data/split_mat_SH_init_ABC.mat', 'split_mat_SH_init_ABC')
% save('./concat_data/split_mat_SH_init_ABD.mat', 'split_mat_SH_init_ABD')
% save('./concat_data/split_mat_SH_init_ACD.mat', 'split_mat_SH_init_ACD')
% save('./concat_data/split_mat_SH_init_BCD.mat', 'split_mat_SH_init_BCD')
% 
% save('./concat_data/split_mat_SH_1_ABC.mat', 'split_mat_SH_1_ABC')
% save('./concat_data/split_mat_SH_1_ABD.mat', 'split_mat_SH_1_ABD')
% save('./concat_data/split_mat_SH_1_ACD.mat', 'split_mat_SH_1_ACD')
% save('./concat_data/split_mat_SH_1_BCD.mat', 'split_mat_SH_1_BCD')
% 
% save('./concat_data/split_mat_LH_1_ABC.mat', 'split_mat_LH_1_ABC')
% save('./concat_data/split_mat_LH_1_ABD.mat', 'split_mat_LH_1_ABD')
% save('./concat_data/split_mat_LH_1_ACD.mat', 'split_mat_LH_1_ACD')
% save('./concat_data/split_mat_LH_1_BCD.mat', 'split_mat_LH_1_BCD')
% 
% save('./concat_data/split_mat_LH_26_ABC.mat', 'split_mat_LH_26_ABC')
% save('./concat_data/split_mat_LH_26_ABD.mat', 'split_mat_LH_26_ABD')
% save('./concat_data/split_mat_LH_26_ACD.mat', 'split_mat_LH_26_ACD')
% save('./concat_data/split_mat_LH_26_BCD.mat', 'split_mat_LH_26_BCD')
% 
% % Make table 
% row_names = {'High_Value_Certain_Standard', 'High_Value_Standard', 'Medium_value_Certain_Standard', 'Medium_value_Standard', 'Novel', 'Low_Value'}';
% 
% T_init = table(split_SH_ABC, split_SH_ABD, split_SH_ACD, split_SH_BCD, 'RowNames', row_names, 'VariableNames', {'init_CS_S_N', 'init_CS_S_L', 'init_CS_N_L', 'init_S_N_L'});
% T_init(T_init.Properties.RowNames(3:4),:) = [];
% 
% T_1st_LH = table(split_LH_ABC_1, split_LH_ABD_1, split_LH_ACD_1, split_LH_BCD_1, 'RowNames', row_names, 'VariableNames', {'LH_1st_CS_S_N', 'LH_1st_CS_S_L', 'LH_1st_CS_N_L', 'LH_1st_S_N_L'});
% T_1st_LH(T_1st_LH.Properties.RowNames(3:4),:) = [];
% 
% T_1st_SH = table(split_SH_ABC_1, split_SH_ABD_1, split_SH_ACD_1, split_SH_BCD_1, 'RowNames', row_names, 'VariableNames', {'SH_1st_CS_S_N', 'SH_1st_CS_S_L', 'SH_1st_CS_N_L', 'SH_1st_S_N_L'});
% T_1st_SH(T_1st_SH.Properties.RowNames(3:4),:) = [];
% 
% T_26_LH = table(split_LH_ABC_26, split_LH_ABD_26, split_LH_ACD_26, split_LH_BCD_26, 'RowNames', row_names, 'VariableNames', {'LH_26_CS_S_N', 'LH_26_CS_S_L', 'LH_26_CS_N_L', 'LH_26_S_N_L'});
% T_26_LH(T_26_LH.Properties.RowNames(3:4),:) = [];
% 
% % Concatenate table
% T = [T_init T_1st_SH T_1st_LH T_26_LH];
% 
% % Inverse
% Ttmp = table2cell(T);
% Tnew = cell2table(Ttmp','RowNames',T.Properties.VariableNames,'VariableNames',T.Properties.RowNames);
% 
% % Export
% writetable(Tnew,'values_ABCD_split.xlsx');
