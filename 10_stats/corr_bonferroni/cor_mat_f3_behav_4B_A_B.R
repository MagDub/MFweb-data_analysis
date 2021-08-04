
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_f3_behav_4B_A_B <- function() {
    
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('pickedD_mean', 'pickedC_mean', 'pickedA_mean', 'pickedB_mean', 'scores_f3')]
  
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
    "Bonferroni corrected (n=", length(p_vec)-1, ") correlations for behaviour",
    ": F3 and low-value bandit: R=", 
    round(df_r$pickedD_mean,3),", p_c=", round(df_p_c$pickedD_mean,3),", p_u=", round(df_p_u$pickedD_mean,3), 
    "; F3 and novel bandit: R=", 
    round(df_r$pickedC_mean,3),", p_c=", round(df_p_c$pickedC_mean,3),", p_u=", round(df_p_u$pickedC_mean,3),
    "; F3 and certain-standard bandit: R=", 
    round(df_r$pickedA_mean,3),", p_c=", round(df_p_c$pickedA_mean,3),", p_u=", round(df_p_u$pickedA_mean,3), 
    "; F3 and standard bandit: R=", 
    round(df_r$pickedB_mean,3),", p_c=", round(df_p_c$pickedB_mean,3),", p_u=", round(df_p_u$pickedB_mean,3),  
    sep='') 
  
  return(output)
  
}




