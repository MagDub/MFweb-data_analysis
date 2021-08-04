function [row_, row_desc] = fct_compute_table_row_freq(data_per_trial, to_del)

    % exclude
    data_per_trial(to_del,:) = nan;

    % Ns
    n_part = size(data_per_trial,1)-size(to_del,2);
    n_trials = size(data_per_trial,2);

    % data
    mean_ = nanmean(data_per_trial,1);
    sem_ = nanstd(data_per_trial)/sqrt(n_part);

    % regression coeff
    beta_ = fct_compute_coeff(data_per_trial, n_trials);
    inter_ = beta_(1,:)';
    slope_ = beta_(2,:)';

    % stats
    [~,p,ci,stats] = ttest(slope_);
    stats_ = strcat('t(', num2str(stats.df), ')=', num2str(stats.tstat,3), ', p=', num2str(p,3), ', 95%CI=[', sprintf('%.2e', ci(1)), ',', sprintf('%.2e', ci(2)) ,']');

    % concat
    row_ = {'', num2str(mean_(end),4), num2str(nanmean(inter_),4), sprintf('%.2e',nanmean(slope_)), stats_}';
    row_desc = {'mean', 'total', 'intercept', 'slope', 'slope_t_test'};

end

