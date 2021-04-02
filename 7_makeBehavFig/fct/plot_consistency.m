
function [] = plot_consistency(to_del)

    data_fold = ('../../data/');

    % Data
    load(strcat(data_fold, 'data_for_figs/consistency_freq_desc.mat'))
    load(strcat(data_fold, 'data_for_figs/consistency_freq.mat'))
    consist_LH = consistency_freq(:,1);
    consist_SH = consistency_freq(:,2);

    % Remove ID
    consist_LH(to_del,:) = [];
    consist_SH(to_del,:) = [];

    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:4;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(consist_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
    plot(x_ax(3)*ones(1,size(consist_SH,1)), consist_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    % Long horizon
    b2L = bar(x_ax(6),nanmean(consist_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    plot(x_ax(6)*ones(1,size(consist_LH,1)), consist_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(consist_SH,1)
        lin2 = plot(x_ax([3 6]),[consist_SH(n) consist_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax([3 6]),[nanmean(consist_SH) nanmean(consist_LH)], ...
        [nanstd(consist_SH)./sqrt(size(consist_SH,1)) nanstd(consist_LH)./sqrt(size(consist_SH,1))],'.','color','k');
    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};

    ylabel('Proportion of same choices [%]','FontName','Arial','Fontweight','bold','FontSize',12,'Interpreter','tex');
    set(gca,'YTick',0:20:100)
    ylim([0 100])
    % 
    % legend([b2S b2L],{'Short horizon', 'Long horizon'}, 'Location', 'NorthWest');
    % legend boxoff  

    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_behaviour_consistency.tif'],'-nocrop','-r200')
end