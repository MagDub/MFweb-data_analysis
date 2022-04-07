
setwd("D:/MFweb/data_analysis/10_stats/additional_analyses")

library(tidyverse)
library(readxl)
library(rstatix)
library(data.table)
library(tidyr)

dataMFweb <- read_excel("../web_data_completed.xlsx", sheet = 'Sheet1') 

# Take only subset: concatenate the ones we want
data_tmp_ <- subset(dataMFweb , select=c("User", "exclude", "age", "IQscore", 
                                         "reward_SH_diff_high", "reward_SH_diff_novel", "reward_SH_diff_low", 
                                         "reward_LHlast_diff_high", "reward_LHlast_diff_novel", "reward_LHlast_diff_low"))

# Exclude
data_tmp <- subset(data_tmp_, exclude!=1)

# Remove rows with na
data_tmp <- na.omit(data_tmp, cols=c("reward_SH_diff_high", "reward_SH_diff_novel", "reward_SH_diff_low", 
                                     "reward_LHlast_diff_high", "reward_LHlast_diff_novel", "reward_LHlast_diff_low"))

# Change from wide to long format
df1 <- pivot_longer(data_tmp, cols=5:7, 
                        names_to = "Bandit", values_to = "Reward_SH")

df2 <- pivot_longer(data_tmp, cols=8:10, 
                         names_to = "Bandit", values_to = "Reward_LH")

df <- subset(df1 , select=c("User", "exclude", "age", "IQscore", "Bandit", "Reward_SH"))
df$Reward_LH = df2$Reward_LH
df$Bandit <- str_replace_all(df$Bandit, 'reward_SH_diff_', '')


# Extract each bandit 
df_high = df[df$Bandit == 'high', ] 
df_novel = df[df$Bandit == 'novel', ] 
df_low = df[df$Bandit == 'low', ] 



