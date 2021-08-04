function [split_col_init, split_col_1, split_mat_SH_init, split_mat_SH_1, desc_split, col_init, col_1, ...
                N_AisH_mat, N_BisH_mat, N_ABisH_mat] = make_col_SH(cond)

    % data folder
    data_fol = '../../../data/sanity_check/';
    
    file_name = strcat('log', cond, 'short_all');

    % For exclusion
    load('../6_exclude/to_exclude.mat')

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

        [trees_, means_, mins_, maxs_, choices_val, choices_min, choices_max, ...
            desc_split, means_split_, mins_split_, maxs_split_, choices_split_val, choices_split_min, choices_split_max, ...
                N_AisH, N_BisH, N_ABisH] = concat_tree_size_init_SH(T);

        N_AisH_mat(ID_n,:) = N_AisH;
        N_BisH_mat(ID_n,:) = N_BisH;
        N_ABisH_mat(ID_n,:) = N_ABisH;

        means_mat(ID_n,:) = means_;
        mins_mat(ID_n,:) = mins_;
        maxs_mat(ID_n,:) = maxs_;
        
        mat_SH_1(ID_n,:) = choices_val(1,:);

        split_mat_SH_init(ID_n,:) = means_split_;
        mins_split_mat(ID_n,:) = mins_split_;
        maxs_split_mat(ID_n,:) = maxs_split_;
        
        split_mat_SH_1(ID_n,:) = choices_split_val(1,:);

    end

    % exclude

    N_AisH_mat(to_del,:) = nan;
    N_BisH_mat(to_del,:) = nan;
    N_ABisH_mat(to_del,:) = nan;

    means_mat(to_del,:) = nan;
    mins_mat(to_del,:) = nan;
    maxs_mat(to_del,:) = nan;
    mat_SH_1(to_del,:) = nan;

    split_mat_SH_init(to_del,:) = nan;
    mins_split_mat(to_del,:) = nan;
    maxs_split_mat(to_del,:) = nan;
    split_mat_SH_1(to_del,:) = nan;
    
    % means
    means_av = nanmean(means_mat);
    means_sd = nanstd(means_mat);
    min_tot = min(mins_mat);
    max_tot = max(maxs_mat);

    means_split_av = nanmean(split_mat_SH_init);
    means_split_sd = nanstd(split_mat_SH_init);
    min_split_tot = min(mins_split_mat);
    max_split_tot = max(maxs_split_mat);
    
    choice1_split_av = nanmean(split_mat_SH_1);
    choice1_split_sd = nanstd(split_mat_SH_1);
    min_choice1_split = min(split_mat_SH_1);
    max_choice1_split = max(split_mat_SH_1);
    
    choice1_av = nanmean(mat_SH_1);
    choice1_sd = nanstd(mat_SH_1);
    min_choice1 = min(mat_SH_1);
    max_choice1 = max(mat_SH_1);
    
    % table
    [col_init] = col_concat(means_av, means_sd, min_tot, max_tot);
    [col_1] = col_concat(choice1_av, choice1_sd, min_choice1, max_choice1);
    
    [split_col_init] = col_concat(means_split_av, means_split_sd, min_split_tot, max_split_tot);
    [split_col_1] = col_concat(choice1_split_av, choice1_split_sd, min_choice1_split, max_choice1_split);

end

