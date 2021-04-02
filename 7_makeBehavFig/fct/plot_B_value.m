
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
load(strcat(data_fold, 'data_for_figs/frequencies.mat'))
pickedB_SH = frequencies(:,2)*100/n_trials_perhor;
pickedB_LH = frequencies(:,6)*100/n_trials_perhor;

save('./frequencies/pickedB_SH.mat', 'pickedB_SH')
save('./frequencies/pickedB_LH.mat', 'pickedB_LH')

save('../../data/data_for_figs/pickedB_SH.mat', 'pickedB_SH')
save('../../data/data_for_figs/pickedB_LH.mat', 'pickedB_LH')

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
pickedB_SH(to_del,:) = nan;
pickedB_SH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:4;

noise_plot = (rand(size(pickedB_SH,1),1)-0.5)/5;

% Short horizon
b2S = bar(x_ax(3),nanmean(pickedB_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
% plot(x_ax(3)*ones(1,size(pickedB_SH,1)), pickedB_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(6),nanmean(pickedB_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
% plot(x_ax(6)*ones(1,size(pickedB_LH,1)), pickedB_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedB_SH,1)
    lin2 = plot(x_ax([3 6])+noise_plot(n),[pickedB_SH(n) pickedB_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax([3 6]),[nanmean(pickedB_SH) nanmean(pickedB_LH)], ...
    [nanstd(pickedB_SH)./sqrt(size(pickedB_SH,1)) nanstd(pickedB_LH)./sqrt(size(pickedB_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([0 2.8])
set(gca,'XTick',[x_ax(3) x_ax(6)])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon'};

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:15:80)
ylim([0 max(max(pickedB_SH),max(pickedB_LH))])

% legend([b2S b2L],{'Short horizon', 'Long horizon'});
% legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_B.tif'],'-nocrop','-r200')