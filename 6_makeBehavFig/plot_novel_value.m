
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
load(strcat(data_fold, 'data_for_figs/frequencies.mat'))
pickedC_SH = frequencies(:,3)*100/n_trials_perhor;
pickedC_LH = frequencies(:,7)*100/n_trials_perhor;

save('./frequencies/pickedC_SH.mat', 'pickedC_SH')
save('./frequencies/pickedC_LH.mat', 'pickedC_LH')

save('../../data/data_for_figs/pickedC_SH.mat', 'pickedC_SH')
save('../../data/data_for_figs/pickedC_LH.mat', 'pickedC_LH')

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = [1.2 1.8];

% Short horizon
b2S = bar(x_ax(1),nanmean(pickedC_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
plot(x_ax(1)*ones(1,size(pickedC_SH,1)), pickedC_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(2),nanmean(pickedC_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
plot(x_ax(2)*ones(1,size(pickedC_LH,1)), pickedC_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedC_SH,1)
    lin2 = plot(x_ax(1:2),[pickedC_SH(n) pickedC_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax,[nanmean(pickedC_SH) nanmean(pickedC_LH)], ...
    [nanstd(pickedC_SH)./sqrt(size(pickedC_SH,1)) nanstd(pickedC_LH)./sqrt(size(pickedC_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([x_ax(1)-0.5 x_ax(2)+0.5])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{''});

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:15:80)
ylim([0 max(max(pickedC_SH),max(pickedC_LH))])

legend([b2S b2L],{'Short horizon', 'Long horizon'});
legend boxoff  

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_behaviour_novel_value.tif'],'-nocrop','-r200')