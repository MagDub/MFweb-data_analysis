
source('~/MFweb/data_analysis/10_stats/additional_analyses/fct_analysis_2way_nocov_perBlock_perHorizon.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'HIGH VALUE ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('pickedhigh_SH_B1', 'pickedhigh_SH_B2', 'pickedhigh_SH_B3', 'pickedhigh_SH_B4', 'pickedhigh_LH_B1', 'pickedhigh_LH_B2', 'pickedhigh_LH_B3', 'pickedhigh_LH_B4'),'','', '',
  'MEDIUM VALUE ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('pickedmedium_SH_B1', 'pickedmedium_SH_B2', 'pickedmedium_SH_B3', 'pickedmedium_SH_B4', 'pickedmedium_LH_B1', 'pickedmedium_LH_B2', 'pickedmedium_LH_B3', 'pickedmedium_LH_B4'),'','', '', 
  'NOVEL VALUE ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('pickednovel_SH_B1', 'pickednovel_SH_B2', 'pickednovel_SH_B3', 'pickednovel_SH_B4', 'pickednovel_LH_B1', 'pickednovel_LH_B2', 'pickednovel_LH_B3', 'pickednovel_LH_B4'),'','', '', 
  'LOW VALUE ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('pickedlow_SH_B1', 'pickedlow_SH_B2', 'pickedlow_SH_B3', 'pickedlow_SH_B4', 'pickedlow_LH_B1', 'pickedlow_LH_B2', 'pickedlow_LH_B3', 'pickedlow_LH_B4') #,'','', '', 
  
  #'SGM0 ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('mod12sgm0_SH_B1', 'mod12sgm0_SH_B2', 'mod12sgm0_SH_B3', 'mod12sgm0_SH_B4', 'mod12sgm0_LH_B1', 'mod12sgm0_LH_B2', 'mod12sgm0_LH_B3', 'mod12sgm0_LH_B4'),'','', '',
  #'EPSILON ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('mod12epsilon_SH_B1', 'mod12epsilon_SH_B2', 'mod12epsilon_SH_B3', 'mod12epsilon_SH_B4', 'mod12epsilon_LH_B1', 'mod12epsilon_LH_B2', 'mod12epsilon_LH_B3', 'mod12epsilon_LH_B4'),'','', '', 
  #'NOV ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('mod12eta_SH_B1', 'mod12eta_SH_B2', 'mod12eta_SH_B3', 'mod12eta_SH_B4', 'mod12eta_LH_B1', 'mod12eta_LH_B2', 'mod12eta_LH_B3', 'mod12eta_LH_B4'),'','', '', 
  
  #'SCORE FIRST ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('score_SH_B1', 'score_SH_B2', 'score_SH_B3', 'score_SH_B4', 'first_LH_B1', 'first_LH_B2', 'first_LH_B3', 'first_LH_B4'),'','', '', 
  #'SCORE TOTAL ', '', rm_anova_MFweb_nocov_perBlock_perHorizon('score_SH_B1', 'score_SH_B2', 'score_SH_B3', 'score_SH_B4', 'score_LH_B1', 'score_LH_B2', 'score_LH_B3', 'score_LH_B4')

)

fileConn<-file("~/MFweb/data_analysis/10_stats/additional_analyses/results_nocov_perBlock_perhorizon_completed.txt")
writeLines(all_text, fileConn)
close(fileConn)

