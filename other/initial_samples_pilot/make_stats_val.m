function [valc1, valc2, stats_] = make_stats_val(split_mat_c1, split_mat_c2)

    c1_mean = nanmean(split_mat_c1);
    c1_sd = nanstd(split_mat_c1);

    c2_mean = nanmean(split_mat_c2);
    c2_sd = nanstd(split_mat_c2);

    valc1 = strcat(num2str(c1_mean,3),' (',num2str(c1_sd,3),')');
    valc2 = strcat(num2str(c2_mean,3),' (',num2str(c2_sd,3),')');

    [h,p,ci,stats] = ttest(split_mat_c1, split_mat_c2);

    stats_ = strcat('t(', num2str(stats.df),')=',num2str(stats.tstat,3),', p=',num2str(p,3), ', 95%CI=[', num2str(ci(1),3), ',', num2str(ci(2),3), ']');

end

