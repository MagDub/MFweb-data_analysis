
source('~/MFweb/data_analysis/10_stats/make_pval_u_.R')

library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_allf_param <- function() {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0', 'scores_f1', 'scores_f2', 'scores_f3')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_small = p_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  r_mat_small = r_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("xi_mean", "eta_mean", "sgm0_mean", "Q0")]
  
  # convert
  vec_p = c(p_mat_small)

  # adjust
  p_vec_adj <- p.adjust(vec_p, method = "bonferroni", n = length(vec_p))

  # convert back
  p_mat = matrix(p_vec_adj,nrow = dim(p_mat_small)[1],ncol = dim(p_mat_small)[2], dimnames=list(rownames(p_mat_small), colnames(p_mat_small)))
  r_mat = r_mat_small
  
  # make df
  df_r=as.data.frame(r_mat)
  
  df_p_c=as.data.frame(p_mat)
  df_p_u=as.data.frame(p_mat_small)
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(vec_p), ") correlations for behaviour",
    ": F1 and epsilon: R=", 
    round(df_r['scores_f1',]$xi_mean,3),", p_c=", round(df_p_c['scores_f1',]$xi_mean,3),", p_u=", make_pval_u_(df_p_u['scores_f1',]$xi_mean), 
    "; F1 and eta: R=", 
    round(df_r['scores_f1',]$eta_mean,3),", p_c=", round(df_p_c['scores_f1',]$eta_mean,3),", p_u=", make_pval_u_(df_p_u['scores_f1',]$eta_mean), 
    "; F1 and sigma0: R=", 
    round(df_r['scores_f1',]$sgm0_mean,3),", p_c=", round(df_p_c['scores_f1',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['scores_f1',]$sgm0_mean), 
    "; F1 and Q0: R=", 
    round(df_r['scores_f1',]$Q0,3),", p_c=", round(df_p_c['scores_f1',]$Q0,3),", ", make_pval_u_(df_p_u['scores_f1',]$Q0), 
    "; F2 and epsilon: R=", 
    round(df_r['scores_f2',]$xi_mean,3),", p_c=", round(df_p_c['scores_f2',]$xi_mean,3),", ", make_pval_u_(df_p_u['scores_f2',]$xi_mean), 
    "; F2 and eta: R=", 
    round(df_r['scores_f2',]$eta_mean,3),", p_c=", round(df_p_c['scores_f2',]$eta_mean,3),", ", make_pval_u_(df_p_u['scores_f2',]$eta_mean), 
    "; F2 and sigma0: R=", 
    round(df_r['scores_f2',]$sgm0_mean,3),", p_c=", round(df_p_c['scores_f2',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['scores_f2',]$sgm0_mean), 
    "; F2 and Q0: R=", 
    round(df_r['scores_f2',]$Q0,3),", p_c=", round(df_p_c['scores_f2',]$Q0,3),", ", make_pval_u_(df_p_u['scores_f2',]$Q0), 
    "; F3 and epsilon: R=", 
    round(df_r['scores_f3',]$xi_mean,3),", p_c=", round(df_p_c['scores_f3',]$xi_mean,3), ", ", make_pval_u_(df_p_u['scores_f3',]$xi_mean), 
    "; F3 and eta: R=", 
    round(df_r['scores_f3',]$eta_mean,3),", p_c=", round(df_p_c['scores_f3',]$eta_mean,3),", ", make_pval_u_(df_p_u['scores_f3',]$eta_mean), 
    "; F3 and sigma0: R=", 
    round(df_r['scores_f3',]$sgm0_mean,3),", p_c=", round(df_p_c['scores_f3',]$sgm0_mean,3),", ", make_pval_u_(df_p_u['scores_f3',]$sgm0_mean),  
    "; F3 and Q0: R=", 
    round(df_r['scores_f3',]$Q0,3),", p_c=", round(df_p_c['scores_f3',]$Q0,3),", ", make_pval_u_(df_p_u['scores_f3',]$Q0), 
    sep='') 
  
  return(output)

}


