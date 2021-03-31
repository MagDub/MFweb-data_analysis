%function [col_init, col_1, split_mat_SH_init, split_mat_SH_1, desc_split] = make_col_SH(cond)
cond = 'ABD';

    % data folder
    data_fol = '../../../data/sanity_check/';
    
    file_name = strcat('log', cond, 'short_all');

    % For exclusion
    to_del = [];
    load('../../usermat_completed.mat')
    to_del(end+1) = find(usermat_completed==4);
    to_del(end+1) = find(usermat_completed==34);
    to_del(end+1) = find(usermat_completed==39);

    load(strcat(data_fol, 'user_1/logs/logdesc.mat'));

    n = size(usermat_completed,2);

    for ID_n = 1:n

        ID = usermat_completed(ID_n);

        T = load(strcat(data_fol, 'user_', num2str(ID), '/logs/', file_name, '.mat'));
        T = T.(file_name);
        
        [trees_, means_, mins_, maxs_, choices_val, choices_min, choices_max, desc_split, means_split_, mins_split_, maxs_split_, choices_split_val, choices_split_min, choices_split_max, N_AisH] = concat_tree_size_init_SH(T);

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
    means_mat(to_del,:) = nan;
    mins_mat(to_del,:) = nan;
    maxs_mat(to_del,:) = nan;

    split_mat_SH_init(to_del,:) = nan;
    mins_split_mat(to_del,:) = nan;
    maxs_split_mat(to_del,:) = nan;
    
    % means
    means_av = nanmean(means_mat);
    means_sd = nanstd(means_mat);

    means_split_av = nanmean(split_mat_SH_init);
    means_split_sd = nanstd(split_mat_SH_init);
    
    min_split_tot = min(mins_split_mat);
    max_split_tot = max(maxs_split_mat);   
    
    % table
    [col_init] = col_concat(means_split_av, means_split_sd, min_split_tot, max_split_tot);

%end

