source('~/MFweb/data_analysis/10_stats/make_pval_u_.R')


library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

cor_mat_BIS_behav_3B <- function() {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")
  
  # keep only mean per horizon
  data_tmp_all <- subset(data_tmp_all, select = -c(3:29))
  
  # Choose which ones to keep
  dataMFweb <- subset(dataMFweb, exclude!=1)
  data_quest <- dataMFweb[, c('BIS11_TotalScore')]
  
  # Choose which ones to keep
  data_all <- data_tmp_all[, c('pickedD_mean', 'pickedC_mean', 'pickedhigh_mean')]
  
  # Concatenate
  data_all[,ncol(data_all)+1] = data_quest[,1]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  r_mat_all <- cor_5$r
  p_mat_all <- cor_5$P
  
  # select column of interest
  p_mat_u = p_mat_all[c("BIS11_TotalScore"),c("pickedD_mean", "pickedC_mean", "pickedhigh_mean")]
  r_mat_small = r_mat_all[c("BIS11_TotalScore"),c("pickedD_mean", "pickedC_mean", "pickedhigh_mean")]

  # adjust
  p_mat <- p.adjust(p_mat_u, method = "bonferroni", n = length(p_mat_u))
  
  # convert back
  r_mat = r_mat_small
  
  # make df
  df_r=as.data.frame(r_mat)
  
  df_p_c=as.data.frame(p_mat)
  df_p_u=as.data.frame(p_mat_u)
  
  # output
  output=paste(
    "Bonferroni corrected (n=", length(p_mat_u), ") correlations for behaviour",
    ": BIS and low-value bandit: R=", 
    round(r_mat['pickedD_mean'],3),", p_c=", round(df_p_c$p_mat[1],3),", ", make_pval_u_(df_p_u$p_mat_u[1]),  
    "; BIS and novel bandit: R=", 
    round(r_mat['pickedC_mean'],3),", p_c=", round(df_p_c$p_mat[2],3),", ", make_pval_u_(df_p_u$p_mat_u[2]), 
    "; BIS and high-value bandit: R=", 
    round(r_mat['pickedhigh_mean'],3),", p_c=", round(df_p_c$p_mat[3],3),", ", make_pval_u_(df_p_u$p_mat_u[3]), 
    sep='') 
  
  return(output)

}


