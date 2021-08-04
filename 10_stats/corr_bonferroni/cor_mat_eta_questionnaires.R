
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)
library(readxl)


cor_mat_eta_questionnaires <- function(x) {
  
  load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")   
  
  # Choose which ones to keep
  data_task <- data_tmp_all[, c(x)]
  dataMFweb <- subset(dataMFweb, exclude!=1)
  data_quest <- dataMFweb[, c('BIS11_TotalScore', 'ASRS_Sum', 'AQ10_TotalScore', 'CFS_TotalScore', 'OCIR_TotalScore', 'STAI_TotalScore', 'IUS_TotalScore', 'SDS_TotalScore', 'LSAS_TotalScore')]
  
  # Concatenate
  data_all = data_quest
  data_all[,ncol(data_all)+1] = data_task[,1]
  
  # Corr mat
  cor_5 <- rcorr(as.matrix(data_all))
  M <- cor_5$r
  p_mat <- cor_5$P
  
  # select column of interest
  p_vec = p_mat[x,]
  M_vec = M[x,]
  
  # adjust (length(p_vec)-1)
  p_vec_adj <- p.adjust(p_vec, method = "bonferroni", n = 36)
  df_r = data.frame(t(M_vec))
  
  df_p_u = data.frame(t(p_vec)) # uncorrected
  df_p_c = data.frame(t(p_vec_adj)) # corrected
  
  # output
  output=paste(
    "Bonferroni corrected (n=", 36, ") correlations",
    ": measure and STAI: R=", 
    round(df_r$STAI_TotalScore,3),", p_c=", round(df_p_c$STAI_TotalScore,3),", p_u=", round(df_p_u$STAI_TotalScore,3),
    "; measure and BIS: R=", 
    round(df_r$BIS11_TotalScore,3),", p_c=", round(df_p_c$BIS11_TotalScore,3),", p_u=", round(df_p_u$BIS11_TotalScore,3), 
    "; measure and ASRS: R=", 
    round(df_r$ASRS_Sum,3),", p_c=", round(df_p_c$ASRS_Sum,3),", p_u=", round(df_p_u$ASRS_Sum,3),
    "; measure and AQ10: R=", 
    round(df_r$AQ10_TotalScore,3),", p_c=", round(df_p_c$AQ10_TotalScore,3),", p_u=", round(df_p_u$AQ10_TotalScore,3), 
    "; measure and OCIR: R=", 
    round(df_r$OCIR_TotalScore,3),", p_c=", round(df_p_c$OCIR_TotalScore,3),", p_u=", round(df_p_u$OCIR_TotalScore,3),
    "; measure and IUS: R=", 
    round(df_r$IUS_TotalScore,3),", p_c=", round(df_p_c$IUS_TotalScore,3),", p_u=", round(df_p_u$IUS_TotalScore,3),
    "; measure and SDS: R=", 
    round(df_r$SDS_TotalScore,3),", p_c=", round(df_p_c$SDS_TotalScore,3),", p_u=", round(df_p_u$SDS_TotalScore,3),
    "; measure and LSAS: R=", 
    round(df_r$LSAS_TotalScore,3),", p_c=", round(df_p_c$LSAS_TotalScore,3),", p_u=", round(df_p_u$LSAS_TotalScore,3),
    "; measure and CFS: R=", 
    round(df_r$CFS_TotalScore,3),", p_c=", round(df_p_c$CFS_TotalScore,3),", p_u=", round(df_p_u$CFS_TotalScore,3), 
    sep='') 
  
return(output)

}




