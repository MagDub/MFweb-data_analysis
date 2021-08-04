# source and then on terminal ex: 
# s<-rm_anova_MF('freq_D_picked_shortH', 'freq_D_picked_longH')

# From example: https://www.datanovia.com/en/lessons/repeated-measures-anova-in-r/

rm_anova_MFweb_nocov_perBlock_perHorizon <- function(x1S, x2S, x3S, x4S, x1L, x2L, x3L, x4L) {

  library(car)
  library(tidyverse)
  library(ggpubr)
  library(rstatix)
  library(readxl)
  library(lsr)
  library(reshape)
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx")    
  
  # Take only subset: concatenate the ones we want
  data_tmp_ <- subset(dataMFweb , select=c("User", "exclude", x1S, x2S, x3S, x4S, x1L, x2L, x3L, x4L))
  
  # Exclude
  data_tmp <- subset(data_tmp_, exclude!=1)
  
  # Split in blocks
  data_b_tmp <- data_tmp %>%
    gather(key = "cond", value = "freq", x1S, x2S, x3S, x4S, x1L, x2L, x3L, x4L) %>%
    convert_as_factor(User, cond)
  
  # Seperate string into multiple columns
  data_ <- data_b_tmp %>% separate(cond, c("meas", "horizon", "block"))
  
  # Summary statistics
  sum_stats <- data_ %>%
    group_by(block, horizon) %>%
    get_summary_stats(freq, type = "mean_sd")
  
  data_sub = subset(data_, select = -c(meas,exclude) )
  
  # Anova computation
  res.aov <- anova_test(
    data = data_sub, dv = freq, wid = User,
    within = c(block, horizon),
    effect.size = "pes"
  )
  
  tab<-get_anova_table(res.aov)
  
  #####
  # Pairwise comparisons - per block
  data_per_B <- data_sub %>%
    pairwise_t_test(freq ~ block, paired = TRUE, p.adjust.method = "none", detailed=TRUE)
  
  # Effect size - horizon
  data_tmp_B <- subset(data_ , select=c("User", "block", "freq"))
  effect_B12 <-cohensD(freq ~ block, data = data_tmp_B[data_tmp_B$block == "B1" | data_tmp_B$block == "B2", ], method = "paired")
  effect_B13 <-cohensD(freq ~ block, data = data_tmp_B[data_tmp_B$block == "B1" | data_tmp_B$block == "B3", ], method = "paired")
  effect_B14 <-cohensD(freq ~ block, data = data_tmp_B[data_tmp_B$block == "B1" | data_tmp_B$block == "B4", ], method = "paired")
  effect_B23 <-cohensD(freq ~ block, data = data_tmp_B[data_tmp_B$block == "B2" | data_tmp_B$block == "B3", ], method = "paired")
  effect_B24 <-cohensD(freq ~ block, data = data_tmp_B[data_tmp_B$block == "B2" | data_tmp_B$block == "B4", ], method = "paired")
  effect_B34 <-cohensD(freq ~ block, data = data_tmp_B[data_tmp_B$block == "B3" | data_tmp_B$block == "B4", ], method = "paired")
  
  #####
  # Pairwise comparisons - per horizon
  data_per_H <- data_sub %>%
    pairwise_t_test(freq ~ horizon, paired = TRUE, p.adjust.method = "none", detailed=TRUE)
  
  # Effect size - horizon
  data_tmp_H <- subset(data_sub , select=c("User", "horizon", "freq"))
  effect_H <-cohensD(freq ~ horizon, data = data_tmp_H, method = "paired")
  
  ####
  # Pairwise comparisons - horizon effect per block
  data_per_BH <- data_sub %>%
    group_by(block) %>%
    pairwise_t_test(freq ~ horizon, paired = TRUE, p.adjust.method = "none", detailed=TRUE)
  
  data_tmp_BH <- subset(data_sub , select=c("User", "horizon", "block", "freq"))
  effect_HB1 <-cohensD(freq ~ horizon, data = data_tmp_BH[data_tmp_BH$block == "B1", ], method = "paired")
  effect_HB2 <-cohensD(freq ~ horizon, data = data_tmp_BH[data_tmp_BH$block == "B2", ], method = "paired")
  effect_HB3 <-cohensD(freq ~ horizon, data = data_tmp_BH[data_tmp_BH$block == "B3", ], method = "paired")
  effect_HB4 <-cohensD(freq ~ horizon, data = data_tmp_BH[data_tmp_BH$block == "B4", ], method = "paired")
  
  # Output main effects
  sentence1=paste(
    "Block main effect: F(", 
    tab$DFn[1],",",tab$DFd[1],")=",round(tab$F[1],3),", p=", round(tab$p[1],3), ", pes=", round(tab$pes[1],3), 
    ";",
    "Horizon main effect: F(", 
    tab$DFn[2],",",tab$DFd[2],")=",round(tab$F[2],3),", p=", round(tab$p[2],3), ", pes=", round(tab$pes[2],3), 
    ";",
    "Block-by-Horizon interaction effect: F(", 
    tab$DFn[3],",",tab$DFd[3],")=",round(tab$F[3],3),", p=", round(tab$p[3],3), ", pes=", round(tab$pes[3],3), 
    ";", sep = "")
  
  # Output pairwise horizon effect
  sentence2=paste(
    "Pairwise comparisons for horizon effect:",
    "(  SH vs LH: t(",
    data_per_H$n1[1],")=", round(data_per_H$statistic[1],3),", p=", round(data_per_H$p[1],3), ", d=", round(effect_H,3), ", 95%CI_M = [", round(data_per_H$conf.low[1],3), ",",round(data_per_H$conf.high[1],3),"]",
    ")", sep = "")
  
  # Output pairwise block effect
  sentence2=paste(
    "Pairwise comparisons for block effect : ",
    "1 vs 2: t(",
    data_per_B$n1[1],")=", round(data_per_B$statistic[1],3),", p=", round(data_per_B$p[1],3), ", d=", round(effect_B12,3), ", 95%CI_M = [", round(data_per_B$conf.low[1],3), ",",round(data_per_B$conf.high[1],3),"]",
    "; 1 vs 3: t(",
    data_per_B$n1[2],")=", round(data_per_B$statistic[2],3),", p=", round(data_per_B$p[2],3), ", d=", round(effect_B13,3), ", 95%CI_M = [", round(data_per_B$conf.low[2],3), ",",round(data_per_B$conf.high[2],3),"]",
    "; 1 vs 4: t(",
    data_per_B$n1[3],")=", round(data_per_B$statistic[3],3),", p=", round(data_per_B$p[3],3), ", d=", round(effect_B14,3), ", 95%CI_M = [", round(data_per_B$conf.low[3],3), ",",round(data_per_B$conf.high[3],3),"]",
    "; 2 vs 3: t(",
    data_per_B$n1[4],")=", round(data_per_B$statistic[4],3),", p=", round(data_per_B$p[4],3), ", d=", round(effect_B23,3), ", 95%CI_M = [", round(data_per_B$conf.low[4],3), ",",round(data_per_B$conf.high[4],3),"]",
    "; 2 vs 4: t(",
    data_per_B$n1[5],")=", round(data_per_B$statistic[5],3),", p=", round(data_per_B$p[5],3), ", d=", round(effect_B24,3), ", 95%CI_M = [", round(data_per_B$conf.low[5],3), ",",round(data_per_B$conf.high[5],3),"]",
    "; 3 vs 4: t(",
    data_per_B$n1[6],")=", round(data_per_B$statistic[6],3),", p=", round(data_per_B$p[6],3), ", d=", round(effect_B34,3), ", 95%CI_M = [", round(data_per_B$conf.low[6],3), ",",round(data_per_B$conf.high[6],3),"]", 
    sep = "")
  
  
  # Output pairwise horizon effect
  sentence3=paste(
    "Pairwise comparisons for interaction effect:", 
    "Horizon effect in Block 1:t(",
    data_per_BH$n1[1],")=", round(data_per_BH$statistic[1],3),", p=", round(data_per_BH$p[1],3), ", d=", round(effect_HB1,3), ", 95%CI = [ ", round(data_per_BH$conf.low[1],3), ",",round(data_per_BH$conf.high[1],3),"]",
    "Horizon effect in Block 2:t(",
    data_per_BH$n1[2],")=", round(data_per_BH$statistic[2],3),", p=", round(data_per_BH$p[2],3), ", d=", round(effect_HB2,3), ", 95%CI_M = [", round(data_per_BH$conf.low[2],3), ",",round(data_per_BH$conf.high[2],3),"]",
    "Horizon effect in Block 3:t(",
    data_per_BH$n1[3],")=", round(data_per_BH$statistic[3],3),", p=", round(data_per_BH$p[3],3), ", d=", round(effect_HB3,3), ", 95%CI_M = [", round(data_per_BH$conf.low[3],3), ",",round(data_per_BH$conf.high[3],3),"]",
    "Horizon effect in Block 4:t(",
    data_per_BH$n1[4],")=", round(data_per_BH$statistic[4],3),", p=", round(data_per_BH$p[4],3), ", d=", round(effect_HB4,3), ", 95%CI_M = [", round(data_per_BH$conf.low[4],3), ",",round(data_per_BH$conf.high[4],3),"]",
    ")", sep = "")
  
  mid=paste("-------------------------------------------------------")
  
  output_txt = c(sentence1,paste(""), mid, paste(""),sentence2,paste(""), mid, paste(""),sentence3,paste(""), mid)
  
  return(output_txt)
}

