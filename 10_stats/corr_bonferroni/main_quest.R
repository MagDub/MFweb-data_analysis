
source('~/MFweb/data_analysis/10_stats/corr_bonferroni/cor_mat_eta_questionnaires.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'Eta :','', cor_mat_eta_questionnaires('eta_mean'),'','', '', 
  'Novel bandit :','', cor_mat_eta_questionnaires('pickedC_mean'),'','', '',
  'Xi :','', cor_mat_eta_questionnaires('xi_mean'),'','', '',
  'Low-value bandit :','', cor_mat_eta_questionnaires('pickedD_mean')
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/corr_bonferroni/results_questionnaires.doc")
writeLines(all_text, fileConn)
close(fileConn)
