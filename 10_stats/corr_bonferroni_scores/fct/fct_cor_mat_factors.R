
source('D:/MFweb/data_analysis/10_stats/make_pval_u_.R')
source('D:/MFweb/data_analysis/10_stats/make_pval_c.R')

library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

fct_cor_mat_factors <- function() {
  
  load(file = "./all_data.Rdata")
  
  # Choose which ones to keep
  data_ <- data_all[, c('scores_f3', 'scores_f2', 'scores_f1', 'average_first_apple')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_biv = p_mat_all[c("average_first_apple"),c("scores_f3", "scores_f2", "scores_f1")]
  r_mat_biv = r_mat_all[c("average_first_apple"),c("scores_f3", "scores_f2", "scores_f1")]
  
  
  ## Bivariate
  
  # make df with r
  df_r_biv=as.data.frame(r_mat_biv)
  p_mat_biv_bon = matrix(p.adjust(c(p_mat_biv), method = "bonferroni", n = length(c(p_mat_biv))), 
                         dimnames=list(rownames(df_r_biv), colnames(df_r_biv)))
  df_p_c=as.data.frame(p_mat_biv_bon)
  df_p_u=as.data.frame(p_mat_biv)
  
  # output
  output_biv=paste(
    "Bonferroni corrected (n=", length(c(p_mat_biv)), ") correlations for parameters",
    ": average_1st_score and scores_f3: R=", 
    round(df_r_biv['scores_f3',],3),", ", make_pval_c(df_p_c['scores_f3',]),", ", make_pval_u_(df_p_u['scores_f3',]), 
    "; average_1st_score and scores_f2: R=", 
    round(df_r_biv['scores_f2',],3),", ", make_pval_c(df_p_c['scores_f2',]),", ", make_pval_u_(df_p_u['scores_f2',]), 
    "; average_1st_score and scores_f1: R=", 
    round(df_r_biv['scores_f1',],3),", ", make_pval_c(df_p_c['scores_f1',]),", ", make_pval_u_(df_p_u['scores_f1',]), 
    sep='') 
  
  
  ## Partial
  
  # adjust R value (partial correlation)
  data_part_ <- data_all[, c('scores_f3', 'scores_f2', 'scores_f1', 'average_first_apple', 'age', 'IQscore')]
  y_data=data.frame(data_part_[complete.cases(data_part_), ]) # remove nans and convert to df
  
  # same col names as r_mat_biv
  r_mat_partial = r_mat_biv
  r_mat_partial['scores_f3']=pcor.test(y_data$average_first_apple, y_data$scores_f3, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['scores_f2']=pcor.test(y_data$average_first_apple, y_data$scores_f2, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['scores_f1']=pcor.test(y_data$average_first_apple, y_data$scores_f1, y_data[,c("age","IQscore")])$estimate

  # same col names as p_mat_biv
  p_mat_partial = p_mat_biv
  p_mat_partial['scores_f3']=pcor.test(y_data$average_first_apple, y_data$scores_f3, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['scores_f2']=pcor.test(y_data$average_first_apple, y_data$scores_f2, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['scores_f1']=pcor.test(y_data$average_first_apple, y_data$scores_f1, y_data[,c("age","IQscore")])$p.value
  
  # make df with r
  df_r_partial=as.data.frame(r_mat_partial)
  p_mat_partial_bon = matrix(p.adjust(c(p_mat_partial), method = "bonferroni", n = length(c(p_mat_partial))),
                         dimnames=list(rownames(df_r_partial), colnames(df_r_partial)))
  df_p_c=as.data.frame(p_mat_partial_bon)
  df_p_u=as.data.frame(p_mat_partial)
  
  # output
  output_part=paste(
    "Bonferroni corrected (n=", length(c(p_mat_partial)), ") correlations for parameters",
    ": average_1st_score and scores_f3: R=", 
    round(df_r_partial['scores_f3',],3),", ", make_pval_c(df_p_c['scores_f3',]),", ", make_pval_u_(df_p_u['scores_f3',]), 
    "; average_1st_score and scores_f2: R=", 
    round(df_r_partial['scores_f2',],3),", ", make_pval_c(df_p_c['scores_f2',]),", ", make_pval_u_(df_p_u['scores_f2',]), 
    "; average_1st_score and scores_f1: R=", 
    round(df_r_partial['scores_f1',],3),", ", make_pval_c(df_p_c['scores_f1',]),", ", make_pval_u_(df_p_u['scores_f1',]), 
    sep='')  
  
  
  
  ## Concatenate
  
  output = c('', '',  
             
             'BIVARIATE:', output_biv, '', '',
             'PARTIAL (corrected for age and IQ):', output_part
             )
    
  
  return(output)

}


