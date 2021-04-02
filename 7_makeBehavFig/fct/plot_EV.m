function [] = plot_EV(to_del)

    data_fold = ('../../data/');
    load('../usermat_completed.mat')
    numel = size(usermat_completed,2);

    load(strcat(data_fold, 'data_for_figs/EV_SH_mat.mat'))
    load(strcat(data_fold, 'data_for_figs/EV_LH_mat.mat'))

    % Remove ID
    EV_SH_mat(to_del,:) = [];
    EV_LH_mat(to_del,:) = [];
    disp(strcat('N=', num2str(size(EV_SH_mat,1))));

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
    b1S= bar(x_ax(3),nanmean(EV_SH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); 

    % data points
    % plot(x_ax(3)*ones(1,size(EV_SH_mat,1))+noise_plot, EV_SH_mat','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3);

    % first LH
    b1Lf = bar(x_ax(6),nanmean(EV_LH_mat),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    % % data points
    % plot(x_ax(6)*ones(1,size(EV_LH_mat,1))+noise_plot, EV_LH_mat','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3); 

    for n = 1:size(EV_LH_mat,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[EV_SH_mat(n) EV_LH_mat(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    h = errorbar(x_ax([3 6]),...
        [nanmean(EV_SH_mat) nanmean(EV_LH_mat)], ...
        [nanstd(EV_SH_mat)./sqrt(numel) nanstd(EV_LH_mat)./sqrt(numel)],'.','color','k');

    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};

    ylabel({'Expected value','of chosen bandit'}','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:0.5:10)
    ylim([min(min([EV_SH_mat EV_LH_mat]))-0.1 max(max([EV_SH_mat EV_LH_mat]))+0.1])

    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_behaviour_EV.tif'],'-nocrop','-r200')

end


