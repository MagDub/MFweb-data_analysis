
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_f3_behav_3B.R')
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_f3_behav_4B_high_med.R')
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_f3_behav_4B_A_B.R')
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_f3_behav_4B_high_1_3.R')
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_f3_param.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'BEHAVIOUR (3 bandits: low, novel, high):','', cor_mat_f3_behav_3B(),'','', '', 
  'BEHAVIOUR (4 bandits: low, novel, high, medium):','', cor_mat_f3_behav_4B_high_med(),'','', '', 
  'BEHAVIOUR (4 bandits: low, novel, certain-standard, standard):','', cor_mat_f3_behav_4B_A_B(),'','', '', 
  'BEHAVIOUR (4 bandits: low, novel, high-3-samples, high-1-sample):','', cor_mat_f3_behav_4B_high_1_3(),'','', '', 
  'PARAMETERS (4: epsilon, eta, sgm0, Q0):', '',cor_mat_f3_param()
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/corr_bonferroni/results_f3.doc")
writeLines(all_text, fileConn)
close(fileConn)
