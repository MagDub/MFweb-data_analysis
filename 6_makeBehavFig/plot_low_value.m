
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

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
pickedlow_SH(to_del,:) = nan;
pickedlow_LH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:4;

noise_plot = (rand(size(pickedD_SH,1),1)-0.5)/5;

% Short horizon
b2S = bar(x_ax(3),nanmean(pickedD_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
% plot(x_ax(3)*ones(1,size(pickedD_SH,1)), pickedD_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(6),nanmean(pickedD_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
% plot(x_ax(6)*ones(1,size(pickedD_LH,1)), pickedD_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedD_SH,1)
    lin2 = plot(x_ax([3 6])+noise_plot(n),[pickedD_SH(n) pickedD_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax([3 6]),[nanmean(pickedD_SH) nanmean(pickedD_LH)], ...
    [nanstd(pickedD_SH)./sqrt(size(pickedD_SH,1)) nanstd(pickedD_LH)./sqrt(size(pickedD_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([0 2.8])
set(gca,'XTick',[x_ax(3) x_ax(6)])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon'};

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:5:80)
ylim([0 max(max(pickedD_SH),max(pickedD_LH))])

legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_low_value.tif'],'-nocrop','-r200')