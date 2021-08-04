
% Data
b1 = load('../../data/data_for_figs/model_parameters_B1.mat');
b2 = load('../../data/data_for_figs/model_parameters_B2.mat');
b3 = load('../../data/data_for_figs/model_parameters_B3.mat');
b4 = load('../../data/data_for_figs/model_parameters_B4.mat');

load('../../data/data_for_figs/model_parameters_per_block_desc.mat')
ind = find(contains(model_parameters_desc,'Q0'));

param = [b1.model_parameters(:,ind), b2.model_parameters(:,ind), b3.model_parameters(:,ind), b4.model_parameters(:,ind)];

Q0 = param;
save('../../data/data_for_figs/mod12_Q0_perB.mat', 'Q0')

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
param(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 1:1:4;

noise_plot = (rand(size(pickedhigh_SH))-0.5)/5;

% Plot
b2S = bar(x_ax([1,2,3,4]),nanmean(param),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([1,2,3,4]).*ones(size(param))+noise_plot, param,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

h = errorbar(x_ax([1,2,3,4]),[nanmean(param)], ...
    [nanstd(param)./sqrt(size(param,1))],'.','color','k');
set(h,'Marker','none')

xlim([-2 7])   
set(gca,'XTick',[mean(x_ax)])
set(gca,'XTickLabel',{''});

ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:2:10)
ylim([0 7])

legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_param_Q0_perBlock.tif'],'-nocrop','-r200')