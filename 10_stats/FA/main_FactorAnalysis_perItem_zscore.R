
# from: https://github.com/MaxRollwage/RollwageDolanFleming/blob/master/Factor_Analysis.R

library(readxl)
library(nFactors)
library(GPArotation)
library("gridExtra")
library(psych)
library(ggplot2)
library(plotly)
library(ggpubr)

# Load data
data_tmp <- read_excel("~/MFweb/data_analysis/10_stats/web_data_completed_Q_items.xlsx")   

# Remove excluded
data <- subset(data_tmp, exclude!=1)

# remove column user and exclude
data_items = subset(data, select = -c(user,exclude))

#find z-scores of each column
data_items_z = sapply(data_items, function(data_items) (data_items-mean(data_items))/sd(data_items))

# Establish number of factors
CNG <- nCng(cor(data_items_z), model="factors", cor = TRUE, details=TRUE)
number_factors=CNG$nFactors 

# run the factor analysis
fa_results= fa(data_items_z, nfactors = number_factors, rotate = "oblimin", fm="ml")

# compute factor scores
factor_scores = factor.scores(data_items_z, fa_results)

data_tmp_all$scores_f1=factor_scores$scores[,1]
data_tmp_all$scores_f2=factor_scores$scores[,2]
data_tmp_all$scores_f3=factor_scores$scores[,3]

# extract factor loadings
loadings <- fa_results$loadings

# PLot the factor loadings
loadingsplot<- 0
loadingsplot = data.frame(loadings[,1],loadings[,2],loadings[,3])

write.csv(loadingsplot,'~/MFweb/data_analysis/10_stats/FA/loadingsplot_z.csv')

loadingsplot$x <- factor(rownames(loadingsplot), levels = rownames(loadingsplot))
# from: colnames(data)
Questionnaires=c(rep("BIS",30), rep("ASRS",18), rep("AQ10",10), rep("CFS",12), 
                 rep("OCIR",18), rep("SDS",20), rep("STAI",20), rep("IUS",27), rep("LSAS",24))
values=c(rep("#999999",30), rep("#E69F00",18), rep("#000000",10), rep("#76EE00",12), 
         rep("#F0E442",18), rep("#0072B2",20), rep("#D55E00",20), rep("#56B4E9",27), rep("#009E73",24))

a<-ggplot(loadingsplot[1], aes(x = loadingsplot$x, y = loadingsplot$loadings...1, fill=Questionnaires)) + 
  geom_bar(stat = "identity", position=position_dodge()) + 
  scale_fill_manual(values=c("#999999", "#E69F00","#000000", "#76EE00","#F0E442","#0072B2","#D55E00", "#56B4E9", "#009E73"), name="Questionnaires", 
                    breaks=c("BIS", "ASRS", "AQ10", "CFS", "OCIR", "SDS", "STAI", "IUS", "LSAS"),
                    labels=c("Impulsivity", "ADHD", "Autism", "Cognitive Flexibility", "OCD", "Depression", "State-Trait Anxiety", "Intolerance of Uncertainty", 
                             "Social Anxiety"))+
  labs(title="Factor 1: Depression-Anxiety", x="", y = "Loadings") + theme_classic(base_size = 14)+ 
  theme(axis.ticks = element_blank() ,axis.text.x = element_blank(),axis.line = element_blank())+
  expand_limits(y=c(-.9,.9))+theme(axis.text=element_text(size=14),axis.title=element_text(size=14))

b<-ggplot(loadingsplot[2], aes(x = loadingsplot$x, y = loadingsplot$loadings...2, fill=Questionnaires)) + 
  geom_bar(stat = "identity") + 
  scale_fill_manual(values=c("#999999", "#E69F00","#000000", "#76EE00","#F0E442","#0072B2","#D55E00", "#56B4E9", "#009E73"), name="Questionnaires", 
                    breaks=c("BIS", "ASRS", "AQ10", "CFS", "OCIR", "SDS", "STAI", "IUS", "LSAS"),
                    labels=c("Impulsivity", "ADHD", "Autism", "Cognitive Flexibility", "OCD", "Depression", "State-Trait Anxiety", "Intolerance of Uncertainty", 
                             "Social Anxiety"))+
  labs(title="Factor 2: OCD-Uncertainty", x="", y = "Loadings") +  theme_classic(base_size = 14)+
  theme(axis.ticks = element_blank() ,axis.text.x = element_blank(),axis.line = element_blank(),legend.title=element_blank())+
  expand_limits(y=c(-.9,.9))+theme(axis.text=element_text(size=14),axis.title=element_text(size=14))


c<-ggplot(-loadingsplot[3], aes(x = loadingsplot$x, y = loadingsplot$loadings...3, fill=Questionnaires)) + 
  geom_bar(stat = "identity") + 
  scale_fill_manual(values=c("#999999", "#E69F00","#000000", "#76EE00","#F0E442","#0072B2","#D55E00", "#56B4E9", "#009E73"), name="Questionnaires", 
                    breaks=c("BIS", "ASRS", "AQ10", "CFS", "OCIR", "SDS", "STAI", "IUS", "LSAS"),
                    labels=c("Impulsivity", "ADHD", "Autism", "Cognitive Flexibility", "OCD", "Depression", "State-Trait Anxiety", "Intolerance of Uncertainty", 
                             "Social Anxiety"))+
  labs(title="Factor 3: Impulsivity", x="Questions", y = "Loadings") +  theme_classic(base_size = 14) +
  theme(axis.ticks = element_blank() ,axis.text.x = element_blank(),axis.line = element_blank(),legend.title=element_blank())+
  expand_limits(y=c(-.9,.9))+theme(axis.text=element_text(size=14),axis.title=element_text(size=14))

png("~/MFweb/data_analysis/10_stats/FA/FA_loadings_indiv_z.png")
fig2 <- grid.arrange(a,b,c, ncol=1,nrow=3)
annotate_figure(fig2, top = text_grob("FA with individual items (with autism and cog flex)", color = "black", face = "bold", size = 14))
dev.off()
