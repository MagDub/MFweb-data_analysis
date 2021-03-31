function [trees_, means_, mins_, maxs_, choices_val, choices_min, choices_max, ...
            desc_split, means_split_, mins_split_, maxs_split_, choices_split_val, choices_split_min, choices_split_max,...
                N_AisH, N_BisH, N_ABisH] = concat_tree_size_init_SH(tmp_all)
        
trials = unique(tmp_all(:,2));

N_AisH=0;
N_BisH=0;
N_ABisH=0;

    for t = 1:size(trials,1)

        tmp_trial = tmp_all(tmp_all(:,2) == trials(t),:);
        tmp_init_samples = tmp_trial(isnan(tmp_trial(:,11)),:);
        tmp_chosen_samples = tmp_trial(~isnan(tmp_trial(:,11)),:);

        [tmp_means, tmp_mins, tmp_maxs] = get_vals(tmp_init_samples);
        
        for i=1:size(tmp_chosen_samples,1) 
            [tmp_] = get_vals(tmp_chosen_samples(i,:));
            tmp_choice_vals(i,:) = tmp_;
        end
                
        means_all(t,:) = tmp_means;
        mins_all(t,:) = tmp_mins;
        maxs_all(t,:) = tmp_maxs;
        
        draw_1(t,:) = tmp_choice_vals(1,:);
     
        trees_ = 1:4;
        [~, ind_m] = max(tmp_means);

        if (tmp_means(1)==tmp_means(2))
            N_ABisH = N_ABisH+1;
            ind_m = 1;
        elseif ind_m==1
            N_AisH = N_AisH+1;
        elseif ind_m==2
            N_BisH = N_BisH+1;
        end       
            
        hv = trees_(ind_m);
        
        HCS_means = nan; HS_means = nan; MCS_means = nan; MS_means = nan;
        HCS_maxs = nan; HS_maxs = nan; MCS_maxs = nan; MS_maxs = nan;
        HCS_mins = nan; HS_mins = nan; MCS_mins = nan; MS_mins = nan;
        
        HCS_choice1=nan;
        HS_choice1=nan; 
        MCS_choice1=nan; 
        MS_choice1=nan; 
        
        if hv == 1
            
            HCS_means = tmp_means(trees_==1);
            HCS_mins = tmp_mins(trees_==1);
            HCS_maxs = tmp_maxs(trees_==1);
            
            HCS_choice1 = tmp_choice_vals(1,trees_==1);
                        
            if ~isempty(find(trees_==2))
                
                MS_means = tmp_means(trees_==2);
                MS_mins = tmp_mins(trees_==2);
                MS_maxs = tmp_maxs(trees_==2);
                
                MS_choice1 = tmp_choice_vals(1,trees_==2);
                
            end
            
        elseif hv == 2
            
            HS_means = tmp_means(trees_==2);
            HS_mins = tmp_mins(trees_==2);
            HS_maxs = tmp_maxs(trees_==2);
            
            HS_choice1 = tmp_choice_vals(1,trees_==2);
            
            if ~isempty(find(trees_==1))
                
                MCS_means = tmp_means(trees_==1);
                MCS_mins = tmp_mins(trees_==1);
                MCS_maxs = tmp_maxs(trees_==1);
                
                MCS_choice1 = tmp_choice_vals(1,trees_==1);
                
            end
            
        end
        
        C_means = nan; D_means = nan;
        C_maxs = nan; D_maxs = nan;
        C_mins = nan; D_mins = nan;
        
        C_choice1=nan; 
        D_choice1=nan; 
        
        if ~isempty(find(trees_==3))
            
            C_means = tmp_means(trees_==3);
            C_maxs = tmp_maxs(trees_==3);
            C_mins = tmp_mins(trees_==3);
            
            C_choice1 = tmp_choice_vals(1,trees_==3);
            
        end
        
        if ~isempty(find(trees_==4))
            
            D_means = tmp_means(trees_==4);
            D_maxs = tmp_maxs(trees_==4);
            D_mins = tmp_mins(trees_==4);
            
            D_choice1 = tmp_choice_vals(1,trees_==4);
        end
        
        means_split(t,:) = [HCS_means, HS_means, MCS_means, MS_means, C_means, D_means];
        maxs_split(t,:) = [HCS_maxs, HS_maxs, MCS_maxs, MS_maxs, C_maxs, D_maxs];
        mins_split(t,:) = [HCS_mins, HS_mins, MCS_mins, MS_mins, C_mins, D_mins];
        
        choice1_split(t,:) = [HCS_choice1, HS_choice1, MCS_choice1, MS_choice1, C_choice1, D_choice1];

    end    
    
    desc_split={'HCS, HS, MCS, MS, N, L'};
    
    means_ = mean(means_all,1);
    mins_ = min(mins_all);
    maxs_ = max(maxs_all);
    
    choices_val(1,:) = nanmean(draw_1,1);
    choices_min(1,:)  = min(draw_1);
    choices_max(1,:)  = max(draw_1);
    
    means_split_ = nanmean(means_split,1);
    mins_split_ = min(mins_split);
    maxs_split_ = max(maxs_split);
    
    choices_split_val(1,:) = nanmean(choice1_split,1);
    choices_split_min(1,:) = min(choice1_split);
    choices_split_max(1,:) = max(choice1_split);
       
end
