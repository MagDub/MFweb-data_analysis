# source and then on terminal ex: 
# s<-rm_anova_MF('freq_D_picked_shortH', 'freq_D_picked_longH')

# From example: https://www.datanovia.com/en/lessons/repeated-measures-anova-in-r/

rm_anova_MFweb_nocov_perCond_perHorizon <- function(xAS, xBS, xAL, xBL) {

  library(car)
  library(tidyverse)
  library(ggpubr)
  library(rstatix)
  library(readxl)
  library(lsr)
  library(reshape)
  
  xAS <- 'pickedhigh_Aexploit_SH'
  xBS <- 'pickedhigh_Bexploit_SH'
  xAL <- 'pickedhigh_Aexploit_LH'
  xBL <- 'pickedhigh_Bexploit_LH'
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  
  # Take only subset: concatenate the ones we want
  data_tmp_ <- subset(dataMFweb , select=c("User", "exclude", xAS, xBS, xAL, xBL))
  
  # Exclude
  data_tmp <- subset(data_tmp_, exclude!=1)
  
  # Split in ABs
  data_b_tmp <- data_tmp %>%
    gather(key = "cond", value = "freq", xAS, xBS, xAL, xBL) %>%
    convert_as_factor(User, cond)
  
  # Seperate string into multiple columns
  data_ <- data_b_tmp %>% separate(cond, c("meas", "AB", "horizon"))
  
  # Summary statistics
  sum_stats <- data_ %>%
    group_by(AB, horizon) %>%
    get_summary_stats(freq, type = "mean_sd")
  
  data_sub = subset(data_, select = -c(meas,exclude) )
  
  # Anova computation
  res.aov <- anova_test(
    data = data_sub, dv = freq, wid = User,
    within = c(AB, horizon),
    effect.size = "pes"
  )
  
  tab<-get_anova_table(res.aov)
  
  #####
  # Pairwise comparisons - per AB
  data_per_AB <- data_sub %>%
    pairwise_t_test(freq ~ AB, paired = TRUE, p.adjust.method = "none", detailed=TRUE)
  
  # Effect size - horizon
  data_tmp_AB <- subset(data_ , select=c("User", "AB", "freq"))
  effect_AB <-cohensD(freq ~ AB, data = data_tmp_AB[data_tmp_AB$AB == "Aexploit" | data_tmp_AB$AB == "Bexploit", ], method = "paired")
  
  #####
  # Pairwise comparisons - per horizon
  data_per_H <- data_sub %>%
    pairwise_t_test(freq ~ horizon, paired = TRUE, p.adjust.method = "none", detailed=TRUE)
  
  # Effect size - horizon
  data_tmp_H <- subset(data_sub , select=c("User", "horizon", "freq"))
  effect_H <-cohensD(freq ~ horizon, data = data_tmp_H, method = "paired")
  
  ####
  # Pairwise comparisons - horizon effect per AB
  data_per_ABH <- data_sub %>%
    group_by(AB) %>%
    pairwise_t_test(freq ~ horizon, paired = TRUE, p.adjust.method = "none", detailed=TRUE)
  
  data_tmp_ABH <- subset(data_sub , select=c("User", "horizon", "AB", "freq"))
  effect_HA <-cohensD(freq ~ horizon, data = data_tmp_ABH[data_tmp_ABH$AB == "Aexploit", ], method = "paired")
  effect_HB <-cohensD(freq ~ horizon, data = data_tmp_ABH[data_tmp_ABH$AB == "Bexploit", ], method = "paired")
  
  # Output main effects
  sentence1=paste(
    "AB main effect: F(", 
    tab$DFn[1],",",tab$DFd[1],")=",round(tab$F[1],3),", p=", round(tab$p[1],3), ", pes=", round(tab$pes[1],3), 
    ";",
    "Horizon main effect: F(", 
    tab$DFn[2],",",tab$DFd[2],")=",round(tab$F[2],3),", p=", round(tab$p[2],3), ", pes=", round(tab$pes[2],3), 
    ";",
    "AB-by-Horizon interaction effect: F(", 
    tab$DFn[3],",",tab$DFd[3],")=",round(tab$F[3],3),", p=", round(tab$p[3],3), ", pes=", round(tab$pes[3],3), 
    ";") 
  
  # Output pairwise horizon effect
  sentence2=paste(
    "Pairwise comparisons for horizon effect:",
    "(  SH vs LH: t(",
    data_per_H$n1[1],")=", round(data_per_H$statistic[1],3),", p=", round(data_per_H$p[1],3), ", d=", round(effect_H,3), ", 95% Confidence interval = ", round(data_per_H$conf.low[1],3), ",",round(data_per_H$conf.high[1],3),
    ")")
  
  # Output pairwise AB effect
  sentence2=paste(
    "Pairwise comparisons for AB effect : ",
    "(  A vs B: t(",
    data_per_AB$n1[1],")=", round(data_per_AB$statistic[1],3),", p=", round(data_per_AB$p[1],3), ", d=", round(effect_AB,3), ", 95% Confidence interval = ", round(data_per_AB$conf.low[1],3), ",",round(data_per_AB$conf.high[1],3),
    ")")
  
  
  # Output pairwise horizon effect
  sentence3=paste(
    "Pairwise comparisons for interaction effect:", 
    "Horizon effect in A: t(",
    data_per_ABH$n1[1],")=", round(data_per_ABH$statistic[1],3),", p=", round(data_per_ABH$p[1],3), ", d=", round(effect_HA,3), ", 95% Confidence interval = ", round(data_per_ABH$conf.low[1],3), ",",round(data_per_ABH$conf.high[1],3),
    "Horizon effect in B: t(",
    data_per_ABH$n1[2],")=", round(data_per_ABH$statistic[2],3),", p=", round(data_per_ABH$p[2],3), ", d=", round(effect_HB,3), ", 95% Confidence interval = ", round(data_per_ABH$conf.low[2],3), ",",round(data_per_ABH$conf.high[2],3),
    ")")
  
  mid=paste("-------------------------------------------------------")
  
  output_txt = c(sentence1,paste(""), mid, paste(""),sentence2,paste(""), mid, paste(""),sentence3,paste(""), mid)
  
  return(output_txt)
}

