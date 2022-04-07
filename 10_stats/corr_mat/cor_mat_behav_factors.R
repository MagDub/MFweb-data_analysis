library(Hmisc)
library(corrplot)
library(ggpubr)
library(ggplot2)

setwd("D:/MFweb/data_analysis/10_stats/corr_mat/")

load(file = "../FA/all_behav_and_FAscores.Rdata")

# keep only mean per horizon
data_tmp_all <- subset(data_tmp_all, select = -c(3:27))

# regorganise columns
data_all <- data_tmp_all[, c(1:3,7:13,4:6)]

cor_5 <- rcorr(as.matrix(data_all))
M <- cor_5$r
p_mat <- cor_5$P
corrplot(M, type = "upper", p.mat = p_mat, sig.level = 0.05, insig = "blank")

# mat
png("~/MFweb/data_analysis/10_stats/corr_mat/corr_mat_behav_factors.png")
corrplot(M, type = "upper", p.mat = p_mat, sig.level = 0.05, insig = "blank")
dev.off()
