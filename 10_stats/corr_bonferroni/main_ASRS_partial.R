
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_ASRS_behav_3B_partial.R')
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_ASRS_param_partial.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'BEHAVIOUR (3 bandits: low, novel, high):','', cor_mat_ASRS_behav_3B_partial(),'','', '', 
  'PARAMETERS (4: epsilon, eta, sgm0, Q0):', '', cor_mat_ASRS_param_partial()
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/corr_bonferroni/results_ASRS_partial.doc")
writeLines(all_text, fileConn)
close(fileConn)
