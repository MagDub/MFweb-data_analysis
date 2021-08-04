%function [trees_, means_, mins_, maxs_, means_split_, mins_split_, maxs_split_, desc_split] = concat_tree_draws(tmp_all)
clear

ID=1;
cond='ABD';
data_fol = '../../../data/sanity_check/';
file_name = strcat('log', cond, 'long_all');
tmp_all = load(strcat(data_fol, 'user_', num2str(ID), '/logs/', file_name, '.mat'));
tmp_all = tmp_all.(file_name);

trials = unique(tmp_all(:,2));

tmp_size = nan(size(trials,1), 4);

    for t = 1:4 %:size(trials,1)

        tmp_trial = tmp_all(tmp_all(:,2) == trials(t),:);
        tmp_draws = tmp_trial(~isnan(tmp_trial(:,11)),:);
        
        % 1st draw
        tmp_draw = tmp_draws(1,:);

        for r = 1:size(tmp_draw,1)
            tree_(r) = find(~isnan(tmp_draw(r,6:9)));
            size_(r) = tmp_draw(r,10);
        end

       tmp_size(t,tree_)=size_;
    
    end

