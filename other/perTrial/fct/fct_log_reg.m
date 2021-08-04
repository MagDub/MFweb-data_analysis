function [res_log_reg] = fct_log_reg(data_, to_del)

    categories_ = sort(unique(data_))';
    slopes_category = categories_;

    for ID = 1:size(data_,1)

        data_per_trial = data_(ID,:);

        x = (1:size(data_,2))';

        data_1 = changem(data_per_trial,[1 0 0 0],categories_);
        data_2 = changem(data_per_trial,[0 1 0 0],categories_);
        data_3 = changem(data_per_trial,[0 0 1 0],categories_);
        data_4 = changem(data_per_trial,[0 0 0 1],categories_);

        [b1] = glmfit(x,data_1','binomial','link','logit');
        [b2] = glmfit(x,data_2','binomial','link','logit');
        [b3] = glmfit(x,data_3','binomial','link','logit');
        [b4] = glmfit(x,data_4','binomial','link','logit');

        slopes_(ID,:) = [b1(2), b2(2), b3(2), b4(2)];

    end

    % exclude
    slopes_(to_del,:) = nan;

    % stats
    for j=1:size(slopes_,2)
        [h,p] = ttest(slopes_(:,j));
        h_mat(j) = h;
        p_mat(j) = p;
    end

    res_log_reg.bandit = slopes_category;
    res_log_reg.h_mat = h_mat;
    res_log_reg.p_mat = p_mat;
    res_log_reg.slope_m = nanmean(slopes_);

end

