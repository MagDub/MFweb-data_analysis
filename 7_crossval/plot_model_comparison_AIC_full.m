
load('mle_mat_all_full.mat')

n_model = size(mle_mat_all,2);

mle_mat_all(4,:) = nan(1,n_model);
mle_mat_all(32,:) = nan(1,n_model);
mle_mat_all(36,:) = nan(1,n_model);

AIC_all = 2*mle_mat_all + 2*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12,   9, 9, 9, 9]; %mle is NLL

mean_all = nanmean(AIC_all,1);
n_part = sum(~isnan(AIC_all));
stderror_all = nanstd(AIC_all,1)./n_part;

% Legend
legend_all{1} = 'thompson';
legend_all{2} = 'thompson + \epsilon';
legend_all{3} = 'thompson + \eta';
legend_all{4} = 'thompson + \epsilon + \eta';

legend_all{5} = 'UCB';
legend_all{6} = 'UCB + \epsilon';
legend_all{7} = 'UCB + \eta';
legend_all{8} = 'UCB + \epsilon + \eta';

legend_all{9} = 'hybrid';
legend_all{10} = 'hybrid + \epsilon';
legend_all{11} = 'hybrid + \eta';
legend_all{12} = 'hybrid + \epsilon + \eta';

legend_all{13} = 'thompson + \eta + \eta_B + \epsilon';
legend_all{14} = 'thompson + \eta + \eta_T + \epsilon';
legend_all{15} = 'thompson + \eta + \epsilon + \epsilon_B' ;
legend_all{16} = 'thompson + \eta + \epsilon + \epsilon_T';

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];
col_(3,:) = [0.674509823322296 0.423529416322708 0.423529416322708];


x = [1:4 6:9 11:14 16:19];

I = 1:1:size(mean_all,2); 

bar(x,mean_all(I),'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;

er = errorbar(x,mean_all(I),stderror_all(I),stderror_all(I));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylabel('AIC score')
yrange = [480 520];
ylim(yrange)
xticks(x)
xticklabels(legend_all(I));
xtickangle(45)
set(gca,'YTick',0:10:1000); grid on;
box off;

hold off

% % Export
% addpath('../../export_fig')
% export_fig(['./fig/Fig_model_comparison_AIC_full.png'],'-nocrop','-r200')