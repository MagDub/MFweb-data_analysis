
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
load(strcat(data_fold, 'data_for_figs/chosenOption.mat'))
pickedmedium_SH = (chosenOption.ABD.freq(:,2)+chosenOption.AB.freq(:,2))*100/n_trials_perhor;
pickedmedium_LH = (chosenOption.ABD.freq(:,5)+chosenOption.AB.freq(:,5))*100/n_trials_perhor;

save('./frequencies/pickedmedium_SH.mat', 'pickedmedium_SH')
save('./frequencies/pickedmedium_LH.mat', 'pickedmedium_LH')

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = [1.2 1.8];

% Short horizon
b2S = bar(x_ax(1),nanmean(pickedmedium_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
plot(x_ax(1)*ones(1,size(pickedmedium_SH,1)), pickedmedium_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(2),nanmean(pickedmedium_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
plot(x_ax(2)*ones(1,size(pickedmedium_LH,1)), pickedmedium_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedmedium_SH,1)
    lin2 = plot(x_ax(1:2),[pickedmedium_SH(n) pickedmedium_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax,[nanmean(pickedmedium_SH) nanmean(pickedmedium_LH)], ...
    [nanstd(pickedmedium_SH)./sqrt(size(pickedmedium_SH,1)) nanstd(pickedmedium_LH)./sqrt(size(pickedmedium_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([x_ax(1)-0.5 x_ax(2)+0.5])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{''});

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:5:80)
ylim([0 max(max(pickedmedium_SH),max(pickedmedium_LH))])

legend([b2S b2L],{'Short horizon', 'Long horizon'});
legend boxoff  

% Export
addpath('../../figures/export_fig')
export_fig(['Fig_behaviour_medium_value.tif'],'-nocrop','-r200')