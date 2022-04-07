
setwd("D:/MFweb/data_analysis/10_stats/corr_bonferroni_scores")

source('fct/fct_cor_mat_param_LH.R')
source('fct/fct_cor_mat_factors_LH.R')

#### ALL GROUPS

all_text = c(
  
  '', '',  

  'PARAMETERS (4: epsilon, eta, sgm0, Q0):', fct_cor_mat_param_LH(), '', '', '', 
  
  'FACTORS (3: F1, F2, F3):', fct_cor_mat_factors_LH()
  
)

fileConn<-file("D:/MFweb/data_analysis/10_stats/corr_bonferroni_scores/results_corr_score_LH.doc")
writeLines(all_text, fileConn)
close(fileConn)

