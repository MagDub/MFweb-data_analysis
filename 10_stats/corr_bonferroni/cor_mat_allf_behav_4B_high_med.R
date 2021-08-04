
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_allf_behav_4B_high_med <- function() {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('pickedD_mean', 'pickedC_mean', 'pickedhigh_mean', 'pickedmedium_mean', 'scores_f1', 'scores_f2', 'scores_f3')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_small = p_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("pickedD_mean", "pickedC_mean", "pickedhigh_mean", "pickedmedium_mean")]
  r_mat_small = r_mat_all[c("scores_f1", "scores_f2", "scores_f3"),c("pickedD_mean", "pickedC_mean", "pickedhigh_mean", "pickedmedium_mean")]
  
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
    ": F1 and low-value bandit: R=", 
    round(df_r['scores_f1',]$pickedD_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedD_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedD_mean,3), 
    "; F1 and novel bandit: R=", 
    round(df_r['scores_f1',]$pickedC_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedC_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedC_mean,3), 
    "; F1 and high-value bandit: R=", 
    round(df_r['scores_f1',]$pickedhigh_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedhigh_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedhigh_mean,3), 
    "; F1 and medium-value bandit: R=", 
    round(df_r['scores_f1',]$pickedmedium_mean,3),", p_c=", round(df_p_c['scores_f1',]$pickedmedium_mean,3),", p_u=", round(df_p_u['scores_f1',]$pickedmedium_mean,3),
    "; F2 and low-value bandit: R=", 
    round(df_r['scores_f2',]$pickedD_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedD_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedD_mean,3), 
    "; F2 and novel bandit: R=", 
    round(df_r['scores_f2',]$pickedC_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedC_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedC_mean,3), 
    "; F2 and high-value bandit: R=", 
    round(df_r['scores_f2',]$pickedhigh_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedhigh_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedhigh_mean,3), 
    "; F2 and medium-value bandit: R=", 
    round(df_r['scores_f2',]$pickedmedium_mean,3),", p_c=", round(df_p_c['scores_f2',]$pickedmedium_mean,3),", p_u=", round(df_p_u['scores_f2',]$pickedmedium_mean,3), 
    "; F3 and low-value bandit: R=", 
    round(df_r['scores_f3',]$pickedD_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedD_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedD_mean,3), 
    "; F3 and novel bandit: R=", 
    round(df_r['scores_f3',]$pickedC_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedC_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedC_mean,3), 
    "; F3 and high-value bandit: R=", 
    round(df_r['scores_f3',]$pickedhigh_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedhigh_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedhigh_mean,3),  
    "; F3 and medium-value bandit: R=", 
    round(df_r['scores_f3',]$pickedmedium_mean,3),", p_c=", round(df_p_c['scores_f3',]$pickedmedium_mean,3),", p_u=", round(df_p_u['scores_f3',]$pickedmedium_mean,3), 
    sep='') 
  
  return(output)

}


