
source("D:/MFweb/data_analysis/10_stats/additional_analyses/fct_analysis_score_per_horizon_for_each_bandit_exact_p.R")

perHor_high = rm_anova_MFweb_F1_cov_exact_p("reward_SH_diff_high", "reward_LHlast_diff_high")
perHor_nov = rm_anova_MFweb_F1_cov_exact_p("reward_SH_diff_novel", "reward_LHlast_diff_novel")
perHor_low = rm_anova_MFweb_F1_cov_exact_p("reward_SH_diff_low", "reward_LHlast_diff_low")

longHor_high_nov = rm_anova_MFweb_F1_cov_exact_p("reward_LHlast_diff_high", "reward_LHlast_diff_novel")
longHor_high_low = rm_anova_MFweb_F1_cov_exact_p("reward_LHlast_diff_high", "reward_LHlast_diff_low")
longHor_novel_low = rm_anova_MFweb_F1_cov_exact_p("reward_LHlast_diff_novel", "reward_LHlast_diff_low")

#reward short horizon vs last reward long horizon: 
#High-value bandit: t(512)=0.246, p=0.806, d=0.011, 
#Novel bandit: t(512)=-15.8, p=4.281e-46, d=0.698,
#low-value bandit: t(488)=-49.213, p=2.419e-191, d=2.226; Last reward long horizon: 
#High-value bandit vs novel bandit: t(512)=-69.411, p=1.262e-262, d=3.065
#High-value bandit vs low-value bandit: t(501)=-13.513, p=1.062e-35, d=0.60
#Novel bandit vs low-value bandit: t(501)=14.786, p=2.589e-41, d=0.66


