
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_allQ_behav_3B.R')
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_allQ_param.R')

#### ALL GROUPS

all_text = c(
  
  '', '',  
  
  'BEHAVIOUR (3 bandits: low, novel, high):','', cor_mat_allQ_behav_3B(),'','', '', 
  'PARAMETERS (4: epsilon, eta, sgm0, Q0):', '',cor_mat_allQ_param()
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/corr_bonferroni/results_allQ.doc")
writeLines(all_text, fileConn)
close(fileConn)
