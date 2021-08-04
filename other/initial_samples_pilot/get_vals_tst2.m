function [ tmp_means,  tmp_mins, tmp_maxs, tree_mat] = get_vals_tst2( tmp_ )

        % init samples
        for r = 1:size(tmp_,1)
            tree_mat(r) = find(~isnan(tmp_(r,6:9)));
            size_(r) = tmp_(r,10);
        end

        tmp_means=nan(1,2);
        tmp_mins=nan(1,2);
        tmp_maxs=nan(1,2);
        
        for tr = 1:2
           i = find(tree_mat==tr);
           if ~isempty(i)
               tmp_means(tr) = mean(size_(i));
               tmp_mins(tr) = min(size_(i));
               tmp_maxs(tr) = max(size_(i));
           end
        end


end

