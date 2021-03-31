
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
load(strcat(data_fold, 'data_for_figs/frequencies.mat'))
pickedA_SH = frequencies(:,1)*100/n_trials_perhor;
pickedA_LH = frequencies(:,5)*100/n_trials_perhor;

save('./frequencies/pickedA_SH.mat', 'pickedA_SH')
save('./frequencies/pickedA_LH.mat', 'pickedA_LH')

save('../../data/data_for_figs/pickedA_SH.mat', 'pickedA_SH')
save('../../data/data_for_figs/pickedA_LH.mat', 'pickedA_LH')

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
pickedA_SH(to_del,:) = nan;
pickedA_SH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:4;

noise_plot = (rand(size(pickedA_SH,1),1)-0.5)/5;

% Short horizon
b2S = bar(x_ax(3),nanmean(pickedA_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
% plot(x_ax(3)*ones(1,size(pickedA_SH,1)), pickedA_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(6),nanmean(pickedA_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
% plot(x_ax(6)*ones(1,size(pickedA_LH,1)), pickedA_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(pickedA_SH,1)
    lin2 = plot(x_ax([3 6])+noise_plot(n),[pickedA_SH(n) pickedA_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax([3 6]),[nanmean(pickedA_SH) nanmean(pickedA_LH)], ...
    [nanstd(pickedA_SH)./sqrt(size(pickedA_SH,1)) nanstd(pickedA_LH)./sqrt(size(pickedA_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([0 2.8])
set(gca,'XTick',[x_ax(3) x_ax(6)])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon'};

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:15:80)
ylim([0 max(max(pickedA_SH),max(pickedA_LH))])

% legend([b2S b2L],{'Short horizon', 'Long horizon'});
% legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_A.tif'],'-nocrop','-r200')