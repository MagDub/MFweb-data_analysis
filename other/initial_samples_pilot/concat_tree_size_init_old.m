function [trees_, means_, mins_, maxs_, means_split_, mins_split_, maxs_split_, desc_split] = concat_tree_size_init(tmp_all)

trials = unique(tmp_all(:,2));

    for t = 1:size(trials,1)

        tmp_trial = tmp_all(tmp_all(:,2) == trials(t),:);
        tmp_init_samples = tmp_trial(isnan(tmp_trial(:,11)),:);

        for r = 1:size(tmp_init_samples,1)
            tree_mat(r) = find(~isnan(tmp_init_samples(r,6:9)));
            size_(r) = tmp_init_samples(r,10);
        end

       trees_ = unique(tree_mat);

        for tr = 1:size(trees_, 2)
           tmp_means(tr) = mean(size_(tree_mat==trees_(tr)));
        end

        for tr = 1:size(trees_, 2)
           tmp_mins(tr) = min(size_(tree_mat==trees_(tr)));
        end

        for tr = 1:size(trees_, 2)
           tmp_maxs(tr) = max(size_(tree_mat==trees_(tr)));
        end

        means_all(t,:) = tmp_means;
        mins_all(t,:) = tmp_mins;
        maxs_all(t,:) = tmp_maxs;
     
        [~, ind_m] = max(tmp_means);
        hv = trees_(ind_m);
        
        HCS_means = nan; HS_means = nan; MCS_means = nan; MS_means = nan;
        HCS_maxs = nan; HS_maxs = nan; MCS_maxs = nan; MS_maxs = nan;
        HCS_mins = nan; HS_mins = nan; MCS_mins = nan; MS_mins = nan;
        
        if hv == 1
            
            HCS_means = tmp_means(trees_==1);
            HCS_mins = tmp_mins(trees_==1);
            HCS_maxs = tmp_maxs(trees_==1);
                        
            if ~isempty(find(trees_==2))
                MS_means = tmp_means(trees_==2);
                MS_mins = tmp_mins(trees_==2);
                MS_maxs = tmp_maxs(trees_==2);
            end
            
        elseif hv == 2
            
            HS_means = tmp_means(trees_==2);
            HS_mins = tmp_mins(trees_==2);
            HS_maxs = tmp_maxs(trees_==2);
            
            if ~isempty(find(trees_==1))
                MCS_means = tmp_means(trees_==1);
                MCS_mins = tmp_mins(trees_==1);
                MCS_maxs = tmp_maxs(trees_==1);
            end
            
        end
        
        C_means = nan; D_means = nan;
        C_maxs = nan; D_maxs = nan;
        C_mins = nan; D_mins = nan;
        
        if ~isempty(find(trees_==3))
            C_means = tmp_means(trees_==3);
            C_maxs = tmp_maxs(trees_==3);
            C_mins = tmp_mins(trees_==3);
        end
        
        if ~isempty(find(trees_==4))
            D_means = tmp_means(trees_==4);
            D_maxs = tmp_maxs(trees_==4);
            D_mins = tmp_mins(trees_==4);
        end
        
        means_split(t,:) = [HCS_means, HS_means, MCS_means, MS_means, C_means, D_means];
        maxs_split(t,:) = [HCS_maxs, HS_maxs, MCS_maxs, MS_maxs, C_maxs, D_maxs];
        mins_split(t,:) = [HCS_mins, HS_mins, MCS_mins, MS_mins, C_mins, D_mins];

    end    
    
    desc_split={'HCS, HS, MCS, MS, N, L'};
    
    means_ = mean(means_all,1);
    mins_ = min(mins_all);
    maxs_ = max(maxs_all);
    
    means_split_ = nanmean(means_split,1);
    mins_split_ = min(mins_split);
    maxs_split_ = max(maxs_split);
       
end

