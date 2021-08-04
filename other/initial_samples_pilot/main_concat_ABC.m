   
clear;

cond = 'AB';

means_mat = nan(67,2);
means_split_mat = nan(67,2);

means_all_cat = [];

for ID = 1:67
    
    if ID~=9 && ID~=7 && ID~=36
        
        data_fol = '../../../data/sanity_check/';
        file_name = strcat('log', cond, 'short_all');
        T = load(strcat(data_fol, 'user_', num2str(ID), '/logs/', file_name, '.mat'));
        T = T.(file_name);
        tmp_all = T;

        trials = unique(tmp_all(:,2));
        
            for t = 1:size(trials,1)
                
                tmp_trial = tmp_all(tmp_all(:,2) == trials(t),:);
                tmp_init_samples = tmp_trial(isnan(tmp_trial(:,11)),:);

                [tmp_means] = get_vals_tst2(tmp_init_samples);

                means_all(t,:) = tmp_means;

            end    
            
            [val_m, ind_m] = max(means_all');

            valHA = val_m(ind_m==1);
            valHB = val_m(ind_m==2);
             
            means_split = [nanmean(valHA), nanmean(valHB)];
            
            means_mat(ID,:) = mean(means_all,1);
            means_split_mat(ID,:) = means_split;
            
            means_all_cat = [means_all_cat; means_all];
            
    else
            means_mat(ID,:) = nan;
            means_split_mat(ID,:) = nan;
    end
    
end

desc_split={'HCS, HS'};

nanmean(means_mat(:,[1 2]))
nanmean(means_split_mat)

save(strcat('concat_data/means_all_cat_',cond,'.mat'), 'means_all_cat')






