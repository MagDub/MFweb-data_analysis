
% Data
b1 = load('../../data/data_for_figs/model_parameters_B1.mat');
b2 = load('../../data/data_for_figs/model_parameters_B2.mat');
b3 = load('../../data/data_for_figs/model_parameters_B3.mat');
b4 = load('../../data/data_for_figs/model_parameters_B4.mat');

load('../../data/data_for_figs/model_parameters_per_block_desc.mat')
ind_SH = find(contains(model_parameters_desc,'eta_short'));
ind_LH = find(contains(model_parameters_desc,'eta_long'));

param_SH = [b1.model_parameters(:,ind_SH), b2.model_parameters(:,ind_SH), b3.model_parameters(:,ind_SH), b4.model_parameters(:,ind_SH)];
param_LH = [b1.model_parameters(:,ind_LH), b2.model_parameters(:,ind_LH), b3.model_parameters(:,ind_LH), b4.model_parameters(:,ind_LH)];

eta_SH = param_SH;
eta_LH = param_LH;
save('../../data/data_for_figs/mod12_eta_SH_perB.mat', 'eta_SH')
save('../../data/data_for_figs/mod12_eta_LH_perB.mat', 'eta_LH')

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
param_SH(to_del,:) = nan;
param_LH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:4;

noise_plot = (rand(size(pickedhigh_SH))-0.5)/5;

% Short horizon
b2S = bar(x_ax([3,4,5,6]),nanmean(param_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([3,4,5,6]).*ones(size(param_SH))+noise_plot, param_SH,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax([8,9,10,11]),nanmean(param_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([8,9,10,11]).*ones(size(param_LH))+noise_plot, param_LH,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

h = errorbar(x_ax([3 4 5 6 8 9 10 11]),[nanmean(param_SH) nanmean(param_LH)], ...
    [nanstd(param_SH)./sqrt(size(param_SH,1)) nanstd(param_LH)./sqrt(size(param_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([0 4.8])
set(gca,'XTick',[   (x_ax(4)+x_ax(5))/2    (x_ax(9)+x_ax(10))/2  ])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon'};

ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:1:10)
ylim([0 5.1])

legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_param_eta_perBlock.tif'],'-nocrop','-r200')