function [freqAisH, freqBisH, freqABisH, stats_AvsB] = make_stats_N(N_AisH_mat_SH, N_BisH_mat_SH, N_ABisH_mat_SH)

    N_AisH_mean = nanmean(N_AisH_mat_SH);
    N_AisH_sd = nanstd(N_AisH_mat_SH);

    N_BisH_mean = nanmean(N_BisH_mat_SH);
    N_BisH_sd = nanstd(N_BisH_mat_SH);

    N_ABisH_mean = nanmean(N_ABisH_mat_SH);
    N_ABisH_sd = nanstd(N_ABisH_mat_SH);

    freqAisH =strcat(num2str(N_AisH_mean,3),' (',num2str(N_AisH_sd,3),')');

    freqBisH = strcat(num2str(N_BisH_mean,3),' (',num2str(N_BisH_sd,3),')');

    [h,p,ci,stats] = ttest(N_AisH_mat_SH, N_BisH_mat_SH);

    stats_AvsB = strcat('t(', num2str(stats.df),')=',num2str(stats.tstat,3),', p=',num2str(p,3), ', 95%CI=[', num2str(ci(1),3), ',', num2str(ci(2),3), ']');

    freqABisH = strcat(num2str(N_ABisH_mean,3),' (',num2str(N_ABisH_sd,3),')');

end

