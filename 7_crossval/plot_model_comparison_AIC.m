
load('mle_mat_all.mat')

n_model = size(mle_mat_all,2);

mle_mat_all(4,:) = nan(1,n_model);
mle_mat_all(32,:) = nan(1,n_model);
mle_mat_all(36,:) = nan(1,n_model);

AIC_all = 2/log(400)*mle_mat_all + 2*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12] ./log(400); %mle is NLL

mean_all = nanmean(AIC_all,1);
n_part = sum(~isnan(AIC_all));
stderror_all = nanstd(AIC_all,1)./n_part;


% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];
col_(3,:) = [0.674509823322296 0.423529416322708 0.423529416322708];


x = [1:4 6:9 11:14];

I = 1:1:size(mean_all,2); 

bar(x,mean_all(I),'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;

er = errorbar(x,mean_all(I),stderror_all(I),stderror_all(I));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylabel('AIC score')
yrange = [81 97];
ylim(yrange)
xticks(x)
xticklabels(legend_all(I));
xtickangle(45)
set(gca,'YTick',0:4:1000);
box off;

hold off

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_model_comparison_AIC.png'],'-nocrop','-r200')