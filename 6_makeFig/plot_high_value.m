
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
load(strcat(data_fold, 'data_for_figs/chosenOption.mat'))
pickedhigh_SH = (chosenOption.ABD.freq(:,1)+chosenOption.AB.freq(:,1)+chosenOption.BD.freq(:,1)+chosenOption.AD.freq(:,1))*100/n_trials_perhor;
pickedhigh_LH = (chosenOption.ABD.freq(:,4)+chosenOption.AB.freq(:,4)+chosenOption.BD.freq(:,4)+chosenOption.AD.freq(:,4))*100/n_trials_perhor;

save('./frequencies/pickedhigh_SH.mat', 'pickedhigh_SH')
save('./frequencies/pickedhigh_LH.mat', 'pickedhigh_LH')

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = [1.2 1.8];

% Short horizon
b2S = bar(x_ax(1),nanmean(pickedhigh_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
plot(x_ax(1)*ones(1,size(pickedhigh_SH,1)), pickedhigh_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(2),nanmean(pickedhigh_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
plot(x_ax(2)*ones(1,size(pickedhigh_LH,1)), pickedhigh_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedhigh_SH,1)
    lin2 = plot(x_ax(1:2),[pickedhigh_SH(n) pickedhigh_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax,[nanmean(pickedhigh_SH) nanmean(pickedhigh_LH)], ...
    [nanstd(pickedhigh_SH)./sqrt(size(pickedhigh_SH,1)) nanstd(pickedhigh_LH)./sqrt(size(pickedhigh_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([x_ax(1)-0.5 x_ax(2)+0.5])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{''});

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:15:80)
ylim([0 80])

legend([b2S b2L],{'Short horizon', 'Long horizon'});
legend boxoff  

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_behaviour_high_value.tif'],'-nocrop','-r200')