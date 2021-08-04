
require(Hmisc)
require(corrplot)

load(file = "~/MFweb/data_analysis/10_stats/FA/all_behav_and_FAscores.Rdata")

# keep only mean per horizon
data_tmp_all <- subset(data_tmp_all, select = -c(3:27))

# regorganise columns
data_all <- data_tmp_all[, c(1:3,7:13,4:6)]

cor_5 <- rcorr(as.matrix(data_all))
M <- cor_5$r
p_mat <- cor_5$P

# mat
corrplot(M, type = "upper", p.mat = p_mat, sig.level = 0.05, insig = "blank")

#indiv
p1 <- ggscatter(data_all, x = "scores_f3", y = "pickedD_mean", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "pearson",
                xlab = "Factor 3: impulsivity", ylab = "Low-value bandit frequency")

p2 <- ggscatter(data_all, x = "scores_f3", y = "xi_mean", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "pearson",
                xlab = "Factor 3: impulsivity", ylab = "epsilon-greedy parameter")

p3 <- ggscatter(data_all, x = "scores_f1", y = "pickedC_mean", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "pearson",
                xlab = "Factor 1: depression-anxiety", ylab = "Novel bandit frequency")

p4 <- ggscatter(data_all, x = "scores_f1", y = "eta_mean", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "pearson",
                xlab = "Factor 1: depression-anxiety", ylab = "novelty bonus")

fig <- ggarrange(p1, p2, p3, p4, ncol = 2, nrow = 2)
print(fig)
