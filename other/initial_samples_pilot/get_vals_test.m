%function [ tmp_means,  tmp_mins, tmp_maxs, tree_mat] = get_vals( tmp_ )
data_fol = '../../../data/sanity_check/';
ID = 1;
cond='ABD';
file_name = strcat('log', cond, 'short_all');
T = load(strcat(data_fol, 'user_', num2str(ID), '/logs/', file_name, '.mat'));
T = T.(file_name);
tmp_all = T;

trials = unique(tmp_all(:,2));

t=8 ;

tmp_trial = tmp_all(tmp_all(:,2) == trials(t),:);
tmp_ = tmp_trial(isnan(tmp_trial(:,11)),:);

disp(tmp_)
        
% init samples
        for r = 1:size(tmp_,1)
            tree_mat(r) = find(~isnan(tmp_(r,6:9)));
            size_(r) = tmp_(r,10);
        end

        trees_ = 1:4;

        tmp_means=nan(1,4);
        tmp_mins=nan(1,4);
        tmp_maxs=nan(1,4);
        
        for tr = 1%:4
           i = find(tree_mat==trees_(tr));
           disp(i)
           if ~isempty(i)
               %tmp_means(tr) = mean(size_(i));
               tmp_means(tr) = mean(size_(i(1)));
               tmp_mins(tr) = min(size_(i));
               tmp_maxs(tr) = max(size_(i));
           end
        end
        
disp('means')
disp(tmp_means)


%end

