
source("D:/MFweb/data_analysis/10_stats/additional_analyses/fct_analysis_score_per_horizon_for_each_bandit.R")

perHor_high = rm_anova_MFweb_F1_cov("reward_SH_diff_high", "reward_LHlast_diff_high")
perHor_nov = rm_anova_MFweb_F1_cov("reward_SH_diff_novel", "reward_LHlast_diff_novel")
perHor_low = rm_anova_MFweb_F1_cov("reward_SH_diff_low", "reward_LHlast_diff_low")

longHor_high_nov = rm_anova_MFweb_F1_cov("reward_LHlast_diff_high", "reward_LHlast_diff_novel")
longHor_high_low = rm_anova_MFweb_F1_cov("reward_LHlast_diff_high", "reward_LHlast_diff_low")
longHor_novel_low = rm_anova_MFweb_F1_cov("reward_LHlast_diff_novel", "reward_LHlast_diff_low")

