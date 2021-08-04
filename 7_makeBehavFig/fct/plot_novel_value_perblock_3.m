
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
b1=load(strcat(data_fold, 'data_for_figs/frequencies_B1.mat'));
b2=load(strcat(data_fold, 'data_for_figs/frequencies_B2.mat'));
b3=load(strcat(data_fold, 'data_for_figs/frequencies_B3.mat'));
b4=load(strcat(data_fold, 'data_for_figs/frequencies_B4.mat'));

pickedC_SH = [b1.frequencies(:,3)*100/n_trials_perhor, b2.frequencies(:,3)*100/n_trials_perhor, b3.frequencies(:,3)*100/n_trials_perhor, b4.frequencies(:,3)*100/n_trials_perhor];
pickedC_LH = [b1.frequencies(:,7)*100/n_trials_perhor, b2.frequencies(:,7)*100/n_trials_perhor, b3.frequencies(:,7)*100/n_trials_perhor, b4.frequencies(:,7)*100/n_trials_perhor];

save('./frequencies/pickedC_SH_perB.mat', 'pickedC_SH')
save('./frequencies/pickedC_LH_perB.mat', 'pickedC_LH')

save('../../data/data_for_figs/pickedC_SH_perB.mat', 'pickedC_SH')
save('../../data/data_for_figs/pickedC_LH_perB.mat', 'pickedC_LH')

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
pickedC_SH(to_del,:) = nan;
pickedC_LH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:10;

noise_plot = (rand(size(pickedC_SH))-0.5)/5;

% Short horizon
b2S = bar(x_ax([3,4,5,6]),nanmean(pickedC_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([3,4,5,6]).*ones(size(pickedC_SH))+noise_plot, pickedC_SH,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax([8,9,10,11]),nanmean(pickedC_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([8,9,10,11]).*ones(size(pickedC_LH))+noise_plot, pickedC_LH,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

h = errorbar(x_ax([3 4 5 6 8 9 10 11]),[nanmean(pickedC_SH) nanmean(pickedC_LH)], ...
    [nanstd(pickedC_SH)./sqrt(size(pickedC_SH,1)) nanstd(pickedC_LH)./sqrt(size(pickedC_LH,1))],'.','color','k');
set(h,'Marker','none')

xlim([0 4.8])
set(gca,'XTick',[   (x_ax(4)+x_ax(5))/2    (x_ax(9)+x_ax(10))/2  ])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon'};

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:4:80)
ylim([0 21])

legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_novel_value_perBlock.tif'],'-nocrop','-r200')