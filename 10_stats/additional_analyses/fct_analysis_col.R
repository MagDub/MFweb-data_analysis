# source and then on terminal ex: 
# s<-rm_anova_MF('freq_D_picked_shortH', 'freq_D_picked_longH')

# From example: https://www.datanovia.com/en/lessons/repeated-measures-anova-in-r/

rm_anova_MFweb_col <- function() {

  library(tidyverse)
  library(readxl)
  library(rstatix)
  
  #library(car)
  #library(ggpubr)
  #library(lsr)
  #library(effectsize)
  
  dataMFweb <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx", sheet = 'cols_2')    
  
  # Change from wide to long format
  data_tmp <- dataMFweb %>%
    gather(key = "bandit", value = "freq", "A", "B", "C", "D") %>%
    convert_as_factor(color, bandit)
  
  # Summary statistics
  data_tmp %>%
    group_by(bandit) %>%
    get_summary_stats(freq, type = "mean_sd")
  
  # Anova computation
  res.aov <- anova_test(
    data = data_tmp, dv = freq, wid = color,
    within = bandit,
    effect.size = "pes"
  )
  
  tab<-get_anova_table(res.aov)
  
  sentence=paste(
    " Bandit main effect: F(",
    tab$DFn[1],",",tab$DFd[1],")=",round(tab$F[1],3),", p=", round(tab$p[1],3), ", pes=", round(tab$pes[1],3),
    ")", sep = "")
  
  return(sentence)
}

