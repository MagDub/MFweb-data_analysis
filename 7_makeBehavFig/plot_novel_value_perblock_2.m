
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

x_ax = 0.5:0.5:10;

all_SH = nanmean(pickedC_SH,2);
all_LH = nanmean(pickedC_LH,2);

n_=nnz(~isnan(all_SH));

pickedC_all = (pickedC_SH + pickedC_LH)/2;

noise_plot = (rand(size(pickedC_SH))-0.5)/5;
noise_plot_concat = (rand(size(all_SH))-0.5)/5;

% Short horizon
b_SH= bar(x_ax(1),nanmean(all_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',0.5); hold on;
plot(x_ax(1)*ones(1,size(all_SH,1))+noise_plot_concat, all_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2); 

% Long horizon
b_LH= bar(x_ax(2),nanmean(all_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',0.5); hold on;
plot(x_ax(2)*ones(1,size(all_LH,1))+noise_plot_concat, all_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2); 

% Dashed line
y_dashed = 0:10:100;
plot(x_ax(3)*ones(size(y_dashed)),y_dashed,'k--', 'MarkerSize',2);

% Blocks
b_block= bar(x_ax([4,5,6,7]),nanmean(pickedC_all),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',1); hold on;
plot(x_ax([4,5,6,7]).*ones(size(pickedC_all))+noise_plot, pickedC_all,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Error bars
h = errorbar(x_ax([1 2 4 5 6 7]),...
    [nanmean(all_SH) nanmean(all_LH) nanmean(pickedC_all)], ...
    [nanstd(all_SH)./sqrt(n_) nanstd(all_SH)./sqrt(n_) nanstd(pickedC_all)./sqrt(n_)],'.','color','k');
set(h,'Marker','none')
    
xlim([0 4])
set(gca,'XTick',[x_ax(1), x_ax(2), x_ax(4), x_ax(5), x_ax(6), x_ax(7)])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon', 'Block 1', 'Block 2', 'Block 3', 'Block 4'};
xtickangle(45)

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:4:80)
max_ = max([pickedC_SH(:); pickedC_LH(:); pickedC_all(:)]);
ylim([0 max_])
 
legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_novel_value_perBlock_2.tif'],'-nocrop','-r200')