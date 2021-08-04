
function [] = plot_IG(to_del)

    load('../usermat_completed.mat')
    data_fold = ('../../data/');
    numel = size(usermat_completed,2);

    load(strcat(data_fold, 'data_for_figs/IS_SH_mat.mat'))
    load(strcat(data_fold, 'data_for_figs/IS_LH_mat.mat'))

    % Remove ID
    IS_SH_mat(to_del,:) = [];
    IS_LH_mat(to_del,:) = [];

    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(usermat_completed,2),1)-0.5)/5;

    % SH
    b1S= bar(x_ax(3),nanmean(IS_SH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); 

    % data points
    % plot(x_ax(3)*ones(1,size(IS_SH_mat,1)), IS_SH_mat','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3);

    % first LH
    b1Lf = bar(x_ax(6),nanmean(IS_LH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    % data points
    % plot(x_ax(6)*ones(1,size(IS_LH_mat,1)), IS_LH_mat','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3); 

    for n = 1:size(IS_LH_mat,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[IS_SH_mat(n) IS_LH_mat(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    h = errorbar(x_ax([3 6])+noise_plot(n),...
        [nanmean(IS_SH_mat) nanmean(IS_LH_mat)], ...
        [nanstd(IS_SH_mat)./sqrt(numel) nanstd(IS_LH_mat)./sqrt(numel)],'.','color','k');

    set(h,'Marker','none')

    xlim([0 2.8])   
    set(gca,'XTick',[x_ax(3) x_ax(6)])

    labels = {'Short horizon', 'Long horizon'};

    a = gca;
    a.XTickLabel = labels;

    ylabel({'Number of initial samples','of chosen bandit'},'FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:0.5:3)
    ylim([min(min([IS_SH_mat IS_LH_mat]))-0.3 max(max([IS_SH_mat IS_LH_mat]))+0.3])

    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_behaviour_IG.tif'],'-nocrop','-r200')
end

