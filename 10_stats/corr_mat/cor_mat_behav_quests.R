
library(readxl)
library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

data_behav_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed.xlsx") 

# Remove excluded
data_behav <- subset(data_behav_tmp, exclude!=1)

# Compute means
data_behav$pickedC_mean = (data_behav$pickedC_SH+data_behav$pickedC_LH)/2
data_behav$pickedD_mean = (data_behav$pickedD_SH+data_behav$pickedD_LH)/2
data_behav$pickedhigh_mean = (data_behav$pickedhigh_SH+data_behav$pickedhigh_LH)/2
data_behav$consistent_mean = (data_behav$consistent_SH+data_behav$consistent_LH)/2
data_behav$xi_mean = (data_behav$xi_SH+data_behav$xi_LH)/2
data_behav$eta_mean = (data_behav$eta_SH+data_behav$eta_LH)/2
data_behav$sgm0_mean = (data_behav$sgm0_SH+data_behav$sgm0_LH)/2

# keep only mean per horizon
data_all <- subset(data_behav, select = c('age', 'gender', 'pickedD_mean', 'pickedC_mean', 'pickedhigh_mean', 
                                              'consistent_mean', 'xi_mean', 'eta_mean', 'sgm0_mean', 
                                              'Q0', 'BIS11_TotalScore', 'AQ10_TotalScore', 'ASRS_Sum', 'CFS_TotalScore', 
                                              'OCIR_TotalScore', 'STAI_TotalScore', 'IUS_TotalScore', 'SDS_TotalScore',
                                              'LSAS_TotalScore'))

cor_5 <- rcorr(as.matrix(data_all))
M <- cor_5$r
p_mat <- cor_5$P
corrplot(M, type = "upper", p.mat = p_mat, sig.level = 0.05, insig = "blank")

# mat
png("~/MFweb/data_analysis/10_stats/corr_mat/corr_mat_behav_quests.png")
corrplot(M, type = "upper", p.mat = p_mat, sig.level = 0.05, insig = "blank")
dev.off()
