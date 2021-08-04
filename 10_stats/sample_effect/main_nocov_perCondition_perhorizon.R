
source('~/MFweb/data_analysis/10_stats/sample_effect/fct_analysis_2way_nocov_perCond_perHorizon.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'HIGH VALUE AB', '', rm_anova_MFweb_nocov_perCond_perHorizon('pickedhigh_Aexploit_SH', 'pickedhigh_Bexploit_SH', 'pickedhigh_Aexploit_LH', 'pickedhigh_Bexploit_LH')

)

fileConn<-file("~/MFweb/data_analysis/10_stats/sample_effect/results_nocov_perCond_perhorizon.txt")
writeLines(all_text, fileConn)
close(fileConn)

