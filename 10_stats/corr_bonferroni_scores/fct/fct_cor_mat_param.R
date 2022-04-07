
source('D:/MFweb/data_analysis/10_stats/make_pval_u_.R')
source('D:/MFweb/data_analysis/10_stats/make_pval_c.R')

library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

fct_cor_mat_param <- function() {
  
  load(file = "./all_data.Rdata")
  
  # Choose which ones to keep
  data_ <- data_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0', 'average_first_apple')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_biv = p_mat_all[c("average_first_apple"),c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  r_mat_biv = r_mat_all[c("average_first_apple"),c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  
  
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
    ": average_1st_score and mean_epsilon: R=", 
    round(df_r_biv['xi_mean',],3),", ", make_pval_c(df_p_c['xi_mean',]),", ", make_pval_u_(df_p_u['xi_mean',]), 
    "; average_1st_score and mean_eta: R=", 
    round(df_r_biv['eta_mean',],3),", ", make_pval_c(df_p_c['eta_mean',]),", ", make_pval_u_(df_p_u['eta_mean',]), 
    "; average_1st_score and mean_sgm0: R=", 
    round(df_r_biv['sgm0_mean',],3),", ", make_pval_c(df_p_c['sgm0_mean',]),", ", make_pval_u_(df_p_u['sgm0_mean',]), 
    "; average_1st_score and Q0: R=", 
    round(df_r_biv['Q0',],3),", ", make_pval_c(df_p_c['Q0',]),", ", make_pval_u_(df_p_u['Q0',]), 
    sep='') 
  
  
  ## Partial
  
  # adjust R value (partial correlation)
  data_part_ <- data_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0', 'average_first_apple', 'age', 'IQscore')]
  y_data=data.frame(data_part_[complete.cases(data_part_), ]) # remove nans and convert to df
  
  # same col names as r_mat_biv
  r_mat_partial = r_mat_biv
  r_mat_partial['xi_mean']=pcor.test(y_data$average_first_apple, y_data$xi_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['eta_mean']=pcor.test(y_data$average_first_apple, y_data$eta_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['sgm0_mean']=pcor.test(y_data$average_first_apple, y_data$sgm0_mean, y_data[,c("age","IQscore")])$estimate
  r_mat_partial['Q0']=pcor.test(y_data$average_first_apple, y_data$Q0, y_data[,c("age","IQscore")])$estimate
  
  # same col names as p_mat_biv
  p_mat_partial = p_mat_biv
  p_mat_partial['xi_mean']=pcor.test(y_data$average_first_apple, y_data$xi_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['eta_mean']=pcor.test(y_data$average_first_apple, y_data$eta_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['sgm0_mean']=pcor.test(y_data$average_first_apple, y_data$sgm0_mean, y_data[,c("age","IQscore")])$p.value
  p_mat_partial['Q0']=pcor.test(y_data$average_first_apple, y_data$Q0, y_data[,c("age","IQscore")])$p.value
  
  # make df with r
  df_r_partial=as.data.frame(r_mat_partial)
  p_mat_partial_bon = matrix(p.adjust(c(p_mat_partial), method = "bonferroni", n = length(c(p_mat_partial))),
                             dimnames=list(rownames(df_r_partial), colnames(df_r_partial)))
  df_p_c=as.data.frame(p_mat_partial_bon)
  df_p_u=as.data.frame(p_mat_partial)
  
  # output
  output_part=paste(
    "Bonferroni corrected (n=", length(c(p_mat_partial)), ") correlations for parameters",
    ": average_1st_score and mean_epsilon: R=", 
    round(df_r_partial['xi_mean',],3),", ", make_pval_c(df_p_c['xi_mean',]),", ", make_pval_u_(df_p_u['xi_mean',]), 
    "; average_1st_score and mean_eta: R=", 
    round(df_r_partial['eta_mean',],3),", ", make_pval_c(df_p_c['eta_mean',]),", ", make_pval_u_(df_p_u['eta_mean',]), 
    "; average_1st_score and mean_sgm0: R=", 
    round(df_r_partial['sgm0_mean',],3),", ", make_pval_c(df_p_c['sgm0_mean',]),", ", make_pval_u_(df_p_u['sgm0_mean',]), 
    "; average_1st_score and Q0: R=", 
    round(df_r_partial['Q0',],3),", ", make_pval_c(df_p_c['Q0',]),", ", make_pval_u_(df_p_u['Q0',]), 
    sep='')  
  
  
  
  ## Concatenate
  
  output = c('', '',  
             
             'BIVARIATE:', output_biv, '', '',
             'PARTIAL (corrected for age and IQ):', output_part
             )
    
  
  return(output)

}


