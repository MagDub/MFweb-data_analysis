
data_fold = ('../../data/');

% Data
load(strcat(data_fold, 'data_for_figs/consistency_freq.mat'))
consist_SH = consistency_freq(:,2);
consist_LH = consistency_freq(:,1);

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.862745106220245 0.862745106220245 0.862745106220245];
col_(2,:) = [0.380392163991928 0.380392163991928 0.380392163991928]; % data points

x_ax = [1 2];

% Short horizon
b2S = bar(x_ax(1),nanmean(consist_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
plot(x_ax(1)*ones(1,size(consist_SH,1)), consist_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(2),nanmean(consist_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
plot(x_ax(2)*ones(1,size(consist_LH,1)), consist_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(idx_plc,1)
    lin2 = plot(x_ax(4:5),[consist_SH consist_LH]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax,[nanmean(consist_SH) nanmean(consist_LH)], ...
    [nanstd(consist_SH)./sqrt(numel) nanstd(consist_LH)./sqrt(numel)],'.','color','k');
set(h,'Marker','none')

xlim([0 4.5])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{'Subjects'});

ylabel('Proportion of same choices [%]','FontName','Arial','Fontweight','bold','FontSize',12,'Interpreter','tex');
set(gca,'YTick',0:10:100)
ylim([0 100])


% % Export
% addpath('../../export_fig')
% export_fig(['Fig_behaviour_consistency.tif'],'-nocrop','-r200')