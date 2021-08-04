
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_f3_param <- function() {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0', 'scores_f3')]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  M <- cor_5$r
  p_mat <- cor_5$P
  
  # select column of interest
  p_vec = p_mat["scores_f3",]
  M_vec = M["scores_f3",]
  
  # adjust
  p_vec_adj <- p.adjust(p_vec, method = "bonferroni", n = length(p_vec)-1)
  df_r = data.frame(t(M_vec))
  
  df_p_u = data.frame(t(p_vec)) # uncorrected
  df_p_c = data.frame(t(p_vec_adj)) # corrected
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(p_vec)-1, ") correlations for model parameters",
    ": F3 and epsilon: R=", 
    round(df_r$xi_mean,3),", p_c=", round(df_p_c$xi_mean,3),", p_u=", round(df_p_u$xi_mean,3), 
    "; F3 and eta: R=", 
    round(df_r$eta_mean,3),", p_c=", round(df_p_c$eta_mean,3),", p_u=", round(df_p_u$eta_mean,3),
    "; F3 and sigma0: R=", 
    round(df_r$sgm0_mean,3),", p_c=", round(df_p_c$sgm0_mean,3),", p_u=", round(df_p_u$sgm0_mean,3), 
    "; F3 and Q0: R=", 
    round(df_r$Q0,3),", p_c=", round(df_p_c$Q0,3),", p_u=", round(df_p_u$Q0,3),
    sep='') 
  
  return(output)

}




