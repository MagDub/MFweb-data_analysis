
% Data
load('../../data/data_for_figs/model_parameters.mat')
load('../../data/data_for_figs/model_parameters_desc.mat')
ind_SH = find(contains(model_parameters_desc,'xi_short'));
ind_LH = find(contains(model_parameters_desc,'xi_long'));
param_SH = model_parameters(:,ind_SH);
param_LH = model_parameters(:,ind_LH);

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = [1.2 1.8];

% Short horizon
b2S = bar(x_ax(1),nanmean(param_SH),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
plot(x_ax(1)*ones(1,size(param_SH,1)), param_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax(2),nanmean(param_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',.5);
plot(x_ax(2)*ones(1,size(param_LH,1)), param_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

for n = 1:size(param_SH,1)
    lin2 = plot(x_ax(1:2),[param_SH(n) param_LH(n)]); hold on;
    lin2.Color = [col_(2,:) 0.3];
end

h = errorbar(x_ax,[nanmean(param_SH) nanmean(param_LH)], ...
    [nanstd(param_SH)./sqrt(size(param_SH,1)) nanstd(param_LH)./sqrt(size(param_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([x_ax(1)-0.5 x_ax(2)+0.5])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{''});

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:0.1:1)
ylim([0 0.53])

legend([b2S b2L],{'Short horizon', 'Long horizon'}, 'location', 'NorthWest');
legend boxoff  

% Export
addpath('../../figures/export_fig')
export_fig(['./fig/Fig_param_epsilon.tif'],'-nocrop','-r200')