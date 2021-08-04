function [col_init, col_1, col_2, col_3, col_4, col_5, col_6, col_26,  ...
    col_init_split, col_1_split, col_2_split, col_3_split, col_4_split, col_5_split, col_6_split, col_26_split, ...
    split_mat_LH_init, split_mat_LH_1, split_mat_LH_26, N_AisH_mat] = make_col_LH(cond)

    % data folder
    data_fol = '../../../data/sanity_check/';
    
    file_name = strcat('log', cond, 'long_all');

    load('../../usermat_completed.mat')
    
    % For exclusion
    load('../../6_exclude/to_exclude.mat')

    to_del = [];
    for i=1:size(to_exclude,2)
        tmp = to_exclude(i);
        to_del(end+1)=find(usermat_completed==tmp);
    end

    load(strcat(data_fol, 'user_1/logs/logdesc.mat'));

    n = size(usermat_completed,2);

    for ID_n = 1:n

        ID = usermat_completed(ID_n);

        T = load(strcat(data_fol, 'user_', num2str(ID), '/logs/', file_name, '.mat'));
        T = T.(file_name);

        [trees_, means_, mins_, maxs_, choices_val, choices_min, choices_max, desc_split, means_split_, mins_split_, maxs_split_, choices_split_val, choices_split_min, choices_split_max, N_AisH] = concat_tree_size_init_LH(T);

        N_AisH_mat(ID_n,:) = N_AisH;
        
        means_mat(ID_n,:) = means_;
        mins_mat(ID_n,:) = mins_;
        maxs_mat(ID_n,:) = maxs_;
        
        mat_LH_1(ID_n,:) = choices_val(1,:);
        mat_LH_2(ID_n,:) = choices_val(2,:);
        mat_LH_3(ID_n,:) = choices_val(3,:);
        mat_LH_4(ID_n,:) = choices_val(4,:);
        mat_LH_5(ID_n,:) = choices_val(5,:);
        mat_LH_6(ID_n,:) = choices_val(6,:);

        split_mat_LH_init(ID_n,:) = means_split_;
        mins_split_mat(ID_n,:) = mins_split_;
        maxs_split_mat(ID_n,:) = maxs_split_;
        
        split_mat_LH_1(ID_n,:) = choices_split_val(1,:);
        split_mat_LH_2(ID_n,:) = choices_split_val(2,:);
        split_mat_LH_3(ID_n,:) = choices_split_val(3,:);
        split_mat_LH_4(ID_n,:) = choices_split_val(4,:);
        split_mat_LH_5(ID_n,:) = choices_split_val(5,:);
        split_mat_LH_6(ID_n,:) = choices_split_val(6,:);

    end

    % exclude

    N_AisH_mat(to_del,:) = nan;

    means_mat(to_del,:) = nan;
    mins_mat(to_del,:) = nan;
    maxs_mat(to_del,:) = nan;
    
    mat_LH_1(to_del,:) = nan;
    mat_LH_2(to_del,:) = nan;
    mat_LH_3(to_del,:) = nan;
    mat_LH_4(to_del,:) = nan;
    mat_LH_5(to_del,:) = nan;
    mat_LH_6(to_del,:) = nan;
    mat_LH_26 = (mat_LH_2+mat_LH_3+mat_LH_4+mat_LH_5+mat_LH_6)/5;

    split_mat_LH_init(to_del,:) = nan;
    mins_split_mat(to_del,:) = nan;
    maxs_split_mat(to_del,:) = nan;
    
    split_mat_LH_1(to_del,:) = nan;
    split_mat_LH_2(to_del,:) = nan;
    split_mat_LH_3(to_del,:) = nan;
    split_mat_LH_4(to_del,:) = nan;
    split_mat_LH_5(to_del,:) = nan;
    split_mat_LH_6(to_del,:) = nan;
    split_mat_LH_26 = (split_mat_LH_2+split_mat_LH_3+split_mat_LH_4+split_mat_LH_5+split_mat_LH_6)/5;
    
    % means
    means_av = nanmean(means_mat);
    means_sd = nanstd(means_mat);
    
    choice1_av = nanmean(mat_LH_1);
    choice1_sd = nanstd(mat_LH_1);
    
    choice2_av = nanmean(mat_LH_2);
    choice2_sd = nanstd(mat_LH_2);
    
    choice3_av = nanmean(mat_LH_3);
    choice3_sd = nanstd(mat_LH_3);
    
    choice4_av = nanmean(mat_LH_4);
    choice4_sd = nanstd(mat_LH_4);
    
    choice5_av = nanmean(mat_LH_5);
    choice5_sd = nanstd(mat_LH_5);
    
    choice6_av = nanmean(mat_LH_6);
    choice6_sd = nanstd(mat_LH_6);

    means_split_av = nanmean(split_mat_LH_init);
    means_split_sd = nanstd(split_mat_LH_init);
    
    choice1_split_av = nanmean(split_mat_LH_1);
    choice1_split_sd = nanstd(split_mat_LH_1);
    
    choice2_split_av = nanmean(split_mat_LH_2);
    choice2_split_sd = nanstd(split_mat_LH_2);
    
    choice3_split_av = nanmean(split_mat_LH_3);
    choice3_split_sd = nanstd(split_mat_LH_3);
    
    choice4_split_av = nanmean(split_mat_LH_4);
    choice4_split_sd = nanstd(split_mat_LH_4);
    
    choice5_split_av = nanmean(split_mat_LH_5);
    choice5_split_sd = nanstd(split_mat_LH_5);
    
    choice6_split_av = nanmean(split_mat_LH_6);
    choice6_split_sd = nanstd(split_mat_LH_6);
    
    min_tot = min(mins_mat);
    max_tot = max(maxs_mat);

    min_split_tot = min(mins_split_mat);
    max_split_tot = max(maxs_split_mat);
    
    min_choice1 = min(mat_LH_1);
    min_choice2 = min(mat_LH_2);
    min_choice3 = min(mat_LH_3);
    min_choice4 = min(mat_LH_4);
    min_choice5 = min(mat_LH_5);
    min_choice6 = min(mat_LH_6);
    
    max_choice1 = max(mat_LH_1);
    max_choice2 = max(mat_LH_2);
    max_choice3 = max(mat_LH_3);
    max_choice4 = max(mat_LH_4);
    max_choice5 = max(mat_LH_5);
    max_choice6 = max(mat_LH_6);
    
    choice26_av = nanmean([choice1_av; choice2_av; choice3_av; choice4_av; choice5_av; choice6_av],1);
    choice26_sd = nanmean([choice1_sd; choice2_sd; choice3_sd; choice4_sd; choice5_sd; choice6_sd],1);
    min_choice26 = min([min_choice2; min_choice3; min_choice4; min_choice5; min_choice6]);
    max_choice26 = max([max_choice2; max_choice3; max_choice4; max_choice5; max_choice6]);
    
    min_choice1_split = min(split_mat_LH_1);
    min_choice2_split = min(split_mat_LH_2);
    min_choice3_split = min(split_mat_LH_3);
    min_choice4_split = min(split_mat_LH_4);
    min_choice5_split = min(split_mat_LH_5);
    min_choice6_split = min(split_mat_LH_6);
    
    max_choice1_split = max(split_mat_LH_1);
    max_choice2_split = max(split_mat_LH_2);
    max_choice3_split = max(split_mat_LH_3);
    max_choice4_split = max(split_mat_LH_4);
    max_choice5_split = max(split_mat_LH_5);
    max_choice6_split = max(split_mat_LH_6);
    
    choice26_split_av = nanmean([choice1_split_av; choice2_split_av; choice3_split_av; choice4_split_av; choice5_split_av; choice6_split_av],1);
    choice26_split_sd = nanmean([choice1_split_sd; choice2_split_sd; choice3_split_sd; choice4_split_sd; choice5_split_sd; choice6_split_sd],1);
    min_choice26_split = min([min_choice2_split; min_choice3_split; min_choice4_split; min_choice5_split; min_choice6_split]);
    max_choice26_split = max([max_choice2_split; max_choice3_split; max_choice4_split; max_choice5_split; max_choice6_split]);

    % table
    [col_init_split] = col_concat(means_split_av, means_split_sd, min_split_tot, max_split_tot);
    [col_1_split] = col_concat(choice1_split_av, choice1_split_sd, min_choice1_split, max_choice1_split);
    [col_2_split] = col_concat(choice2_split_av, choice2_split_sd, min_choice2_split, max_choice2_split);
    [col_3_split] = col_concat(choice3_split_av, choice3_split_sd, min_choice3_split, max_choice3_split);
    [col_4_split] = col_concat(choice4_split_av, choice4_split_sd, min_choice4_split, max_choice4_split);
    [col_5_split] = col_concat(choice5_split_av, choice5_split_sd, min_choice5_split, max_choice5_split);
    [col_6_split] = col_concat(choice6_split_av, choice6_split_sd, min_choice6_split, max_choice6_split);
    [col_26_split] = col_concat(choice26_split_av, choice26_split_sd, min_choice26_split, max_choice26_split);
    
    [col_init] = col_concat(means_av, means_sd, min_tot, max_tot);
    [col_1] = col_concat(choice1_av, choice1_sd, min_choice1, max_choice1);
    [col_2] = col_concat(choice2_av, choice2_sd, min_choice2, max_choice2);
    [col_3] = col_concat(choice3_av, choice3_sd, min_choice3, max_choice3);
    [col_4] = col_concat(choice4_av, choice4_sd, min_choice4, max_choice4);
    [col_5] = col_concat(choice5_av, choice5_sd, min_choice5, max_choice5);
    [col_6] = col_concat(choice6_av, choice6_sd, min_choice6, max_choice6);
    [col_26] = col_concat(choice26_av, choice26_sd, min_choice26, max_choice26);

end

