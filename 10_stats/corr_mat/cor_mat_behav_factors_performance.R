library(Hmisc)
library(corrplot)
library(readxl)

setwd("D:/MFweb/data_analysis/10_stats/corr_mat/")

load(file = "../FA/all_behav_and_FAscores.Rdata")

data_all <- read_excel("../web_data_completed.xlsx")
data_all = data_all[data_all$exclude == FALSE,]
data_all$xi_mean = (data_all$xi_SH + data_all$xi_LH)/2
data_all$eta_mean = (data_all$eta_SH + data_all$eta_LH)/2
data_all$sgm0_mean = (data_all$sgm0_SH + data_all$sgm0_LH)/2
data_all$average_first_apple = (data_all$average_first_apple_SH + data_all$average_first_apple_LH)/2
data_all$scores_f1 = data_tmp_all$scores_f1
data_all$scores_f2 = data_tmp_all$scores_f2
data_all$scores_f3 = data_tmp_all$scores_f3

save(data_all, file = "../corr_bonferroni_scores/all_data.Rdata")

# Score and mean parameter per horizon
data_ <- data_all[, c('xi_mean', 'eta_mean', 'sgm0_mean', 'Q0', 'average_first_apple')]
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
png("./corr_mat_performance_vs_param_mean.png")
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
dev.off()

# Score and long horizon parameter
data_ <- data_all[, c('xi_LH', 'eta_LH', 'sgm0_LH', 'Q0', 'average_first_apple_LH', 'average_all_apple_LH')]
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
png("./corr_mat_performance_vs_param_LH.png")
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
dev.off()

# Score and short horizon parameter
data_ <- data_all[, c('xi_SH', 'eta_SH', 'sgm0_SH', 'Q0', 'average_first_apple_SH')]
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
png("./corr_mat_performance_vs_param_SH.png")
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
dev.off()

# Score and factors
data_ <- data_all[, c('scores_f1', 'scores_f2', 'scores_f3', 'average_first_apple', 'average_first_apple_SH', 'average_first_apple_LH')]
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
png("./corr_mat_performance_vs_factors.png")
corrplot(rcorr(as.matrix(data_))$r, p.mat = rcorr(as.matrix(data_))$p, type = "upper", sig.level = 0.05, insig = "blank")
dev.off()