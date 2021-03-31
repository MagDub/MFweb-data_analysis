function [trees_, means_, mins_, maxs_, choices_val, choices_min, choices_max, ...
    desc_split, means_split_, mins_split_, maxs_split_, choices_split_val, choices_split_min, choices_split_max, N_AisH] = concat_tree_size_init_LH(tmp_all)
        
trials = unique(tmp_all(:,2));

N_AisH=0;

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
        draw_2(t,:) = tmp_choice_vals(2,:);
        draw_3(t,:) = tmp_choice_vals(3,:);
        draw_4(t,:) = tmp_choice_vals(4,:);
        draw_5(t,:) = tmp_choice_vals(5,:);
        draw_6(t,:) = tmp_choice_vals(6,:);
     
        trees_ = 1:4;
        [~, ind_m] = max(tmp_means);
        
        if (tmp_means(1)==tmp_means(2))
                ind_m = 1;
        end
        
        if ind_m==1
            N_AisH = N_AisH+1;
        end
        
        hv = trees_(ind_m);
        
        HCS_means = nan; HS_means = nan; MCS_means = nan; MS_means = nan;
        HCS_maxs = nan; HS_maxs = nan; MCS_maxs = nan; MS_maxs = nan;
        HCS_mins = nan; HS_mins = nan; MCS_mins = nan; MS_mins = nan;
        
        HCS_choice1=nan; HCS_choice2=nan; HCS_choice3=nan; HCS_choice4=nan; HCS_choice5=nan; HCS_choice6=nan;
        HS_choice1=nan; HS_choice2=nan; HS_choice3=nan; HS_choice4=nan; HS_choice5=nan; HS_choice6=nan;
        MCS_choice1=nan; MCS_choice2=nan; MCS_choice3=nan; MCS_choice4=nan; MCS_choice5=nan; MCS_choice6=nan;
        MS_choice1=nan; MS_choice2=nan; MS_choice3=nan; MS_choice4=nan; MS_choice5=nan; MS_choice6=nan;
        
        if hv == 1
            
            HCS_means = tmp_means(trees_==1);
            HCS_mins = tmp_mins(trees_==1);
            HCS_maxs = tmp_maxs(trees_==1);
            
            HCS_choice1 = tmp_choice_vals(1,trees_==1);
            HCS_choice2 = tmp_choice_vals(2,trees_==1);
            HCS_choice3 = tmp_choice_vals(3,trees_==1);
            HCS_choice4 = tmp_choice_vals(4,trees_==1);
            HCS_choice5 = tmp_choice_vals(5,trees_==1);
            HCS_choice6 = tmp_choice_vals(6,trees_==1);
                        
            if ~isempty(find(trees_==2))
                
                MS_means = tmp_means(trees_==2);
                MS_mins = tmp_mins(trees_==2);
                MS_maxs = tmp_maxs(trees_==2);
                
                MS_choice1 = tmp_choice_vals(1,trees_==2);
                MS_choice2 = tmp_choice_vals(2,trees_==2);
                MS_choice3 = tmp_choice_vals(3,trees_==2);
                MS_choice4 = tmp_choice_vals(4,trees_==2);
                MS_choice5 = tmp_choice_vals(5,trees_==2);
                MS_choice6 = tmp_choice_vals(6,trees_==2);
                
            end
            
        elseif hv == 2
            
            HS_means = tmp_means(trees_==2);
            HS_mins = tmp_mins(trees_==2);
            HS_maxs = tmp_maxs(trees_==2);
            
            HS_choice1 = tmp_choice_vals(1,trees_==2);
            HS_choice2 = tmp_choice_vals(2,trees_==2);
            HS_choice3 = tmp_choice_vals(3,trees_==2);
            HS_choice4 = tmp_choice_vals(4,trees_==2);
            HS_choice5 = tmp_choice_vals(5,trees_==2);
            HS_choice6 = tmp_choice_vals(6,trees_==2);
            
            if ~isempty(find(trees_==1))
                
                MCS_means = tmp_means(trees_==1);
                MCS_mins = tmp_mins(trees_==1);
                MCS_maxs = tmp_maxs(trees_==1);
                
                MCS_choice1 = tmp_choice_vals(1,trees_==1);
                MCS_choice2 = tmp_choice_vals(2,trees_==1);
                MCS_choice3 = tmp_choice_vals(3,trees_==1);
                MCS_choice4 = tmp_choice_vals(4,trees_==1);
                MCS_choice5 = tmp_choice_vals(5,trees_==1);
                MCS_choice6 = tmp_choice_vals(6,trees_==1);
                
            end
            
        end
        
        C_means = nan; D_means = nan;
        C_maxs = nan; D_maxs = nan;
        C_mins = nan; D_mins = nan;
        
        C_choice1=nan; C_choice2=nan; C_choice3=nan; C_choice4=nan; C_choice5=nan; C_choice6=nan;
        D_choice1=nan; D_choice2=nan; D_choice3=nan; D_choice4=nan; D_choice5=nan; D_choice6=nan;
        
        if ~isempty(find(trees_==3))
            
            C_means = tmp_means(trees_==3);
            C_maxs = tmp_maxs(trees_==3);
            C_mins = tmp_mins(trees_==3);
            
            C_choice1 = tmp_choice_vals(1,trees_==3);
            C_choice2 = tmp_choice_vals(2,trees_==3);
            C_choice3 = tmp_choice_vals(3,trees_==3);
            C_choice4 = tmp_choice_vals(4,trees_==3);
            C_choice5 = tmp_choice_vals(5,trees_==3);
            C_choice6 = tmp_choice_vals(6,trees_==3);
            
        end
        
        if ~isempty(find(trees_==4))
            
            D_means = tmp_means(trees_==4);
            D_maxs = tmp_maxs(trees_==4);
            D_mins = tmp_mins(trees_==4);
            
            D_choice1 = tmp_choice_vals(1,trees_==4);
            D_choice2 = tmp_choice_vals(2,trees_==4);
            D_choice3 = tmp_choice_vals(3,trees_==4);
            D_choice4 = tmp_choice_vals(4,trees_==4);
            D_choice5 = tmp_choice_vals(5,trees_==4);
            D_choice6 = tmp_choice_vals(6,trees_==4);
        end
        
        means_split(t,:) = [HCS_means, HS_means, MCS_means, MS_means, C_means, D_means];
        maxs_split(t,:) = [HCS_maxs, HS_maxs, MCS_maxs, MS_maxs, C_maxs, D_maxs];
        mins_split(t,:) = [HCS_mins, HS_mins, MCS_mins, MS_mins, C_mins, D_mins];
        
        choice1_split(t,:) = [HCS_choice1, HS_choice1, MCS_choice1, MS_choice1, C_choice1, D_choice1];
        choice2_split(t,:) = [HCS_choice2, HS_choice2, MCS_choice2, MS_choice2, C_choice2, D_choice2];
        choice3_split(t,:) = [HCS_choice3, HS_choice3, MCS_choice3, MS_choice3, C_choice3, D_choice3];
        choice4_split(t,:) = [HCS_choice4, HS_choice4, MCS_choice4, MS_choice4, C_choice4, D_choice4];
        choice5_split(t,:) = [HCS_choice5, HS_choice5, MCS_choice5, MS_choice5, C_choice5, D_choice5];
        choice6_split(t,:) = [HCS_choice6, HS_choice6, MCS_choice6, MS_choice6, C_choice6, D_choice6];

    end    
    
    desc_split={'HCS, HS, MCS, MS, N, L'};
    
    means_ = mean(means_all,1);
    mins_ = min(mins_all);
    maxs_ = max(maxs_all);
    
    choices_val(1,:)  = nanmean(draw_1,1);
    choices_min(1,:)  = min(draw_1);
    choices_max(1,:)  = max(draw_1);
    
    choices_val(2,:)  = nanmean(draw_2,1);
    choices_min(2,:)  = min(draw_2);
    choices_max(2,:)  = max(draw_2);
    
    choices_val(3,:)  = nanmean(draw_3,1);
    choices_min(3,:)  = min(draw_3);
    choices_max(3,:)  = max(draw_3);
    
    choices_val(4,:)  = nanmean(draw_4,1);
    choices_min(4,:)  = min(draw_4);
    choices_max(4,:)  = max(draw_4);
    
    choices_val(5,:)  = nanmean(draw_5,1);
    choices_min(5,:)  = min(draw_5);
    choices_max(5,:)  = max(draw_5);
    
    choices_val(6,:)  = nanmean(draw_6,1);
    choices_min(6,:)  = min(draw_6);
    choices_max(6,:)  = max(draw_6);
    
    means_split_ = nanmean(means_split,1);
    mins_split_ = min(mins_split);
    maxs_split_ = max(maxs_split);
    
    choices_split_val(1,:) = nanmean(choice1_split,1);
    choices_split_min(1,:) = min(choice1_split);
    choices_split_max(1,:) = max(choice1_split);
    
    choices_split_val(2,:) = nanmean(choice2_split,1);
    choices_split_min(2,:) = min(choice2_split);
    choices_split_max(2,:) = max(choice2_split);
    
    choices_split_val(3,:) = nanmean(choice3_split,1);
    choices_split_min(3,:) = min(choice3_split);
    choices_split_max(3,:) = max(choice3_split);
    
    choices_split_val(4,:) = nanmean(choice4_split,1);
    choices_split_min(4,:) = min(choice4_split);
    choices_split_max(4,:) = max(choice4_split);
    
    choices_split_val(5,:) = nanmean(choice5_split,1);
    choices_split_min(5,:) = min(choice5_split);
    choices_split_max(5,:) = max(choice5_split);
    
    choices_split_val(6,:) = nanmean(choice6_split,1);
    choices_split_min(6,:) = min(choice6_split);
    choices_split_max(6,:) = max(choice6_split);
       
end
