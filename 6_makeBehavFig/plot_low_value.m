
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
load(strcat(data_fold, 'data_for_figs/frequencies.mat'))
pickedD_SH = frequencies(:,4)*100/n_trials_perhor;
pickedD_LH = frequencies(:,8)*100/n_trials_perhor;

save('./frequencies/pickedD_SH.mat', 'pickedD_SH')
save('./frequencies/pickedD_LH.mat', 'pickedD_LH')

save('../../data/data_for_figs/pickedD_SH.mat', 'pickedD_SH')
save('../../data/data_for_figs/pickedD_LH.mat', 'pickedD_LH')

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = [1.2 1.8];

% Short horizon
b2S = bar(x_ax(1),nanmean(pickedD_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
plot(x_ax(1)*ones(1,size(pickedD_SH,1)), pickedD_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(2),nanmean(pickedD_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
plot(x_ax(2)*ones(1,size(pickedD_LH,1)), pickedD_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedD_SH,1)
    lin2 = plot(x_ax(1:2),[pickedD_SH(n) pickedD_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax,[nanmean(pickedD_SH) nanmean(pickedD_LH)], ...
    [nanstd(pickedD_SH)./sqrt(size(pickedD_SH,1)) nanstd(pickedD_LH)./sqrt(size(pickedD_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([x_ax(1)-0.5 x_ax(2)+0.5])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{''});

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:5:80)
ylim([0 max(max(pickedD_SH),max(pickedD_LH))])

legend([b2S b2L],{'Short horizon', 'Long horizon'});
legend boxoff  

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_behaviour_low_value.tif'],'-nocrop','-r200')