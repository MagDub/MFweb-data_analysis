
source('~/MFweb/data_analysis/10_stats/additional_analyses/fct_analysis_col.R')

#### ALL GROUPS

all_text = c(
  
  '', '', 
  
  'Colour ', '', rm_anova_MFweb_col()
  
)

fileConn<-file("~/MFweb/data_analysis/10_stats/additional_analyses/results_col.doc")
writeLines(all_text, fileConn)
close(fileConn)
