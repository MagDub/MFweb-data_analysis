
function [] = plot_score(to_del)

    data_fold = ('../../data/');
    load(strcat(data_fold, 'data_for_figs/score.mat'))
    load(strcat(data_fold, 'data_for_figs/score_desc.mat'))

    score_SH = score(:,2);
    first_LH = score(:,3);
    score_LH = score(:,4);

    load('../usermat_completed.mat')

    % Remove ID
    score_SH(to_del,:) = [];
    score_LH(to_del,:) = [];
    first_LH(to_del,:) = [];

    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(score_SH,1),1)-0.5)/5;

    % SH
    b1S= bar(x_ax(3),nanmean(score_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); 

    % % data points
    % plot(x_ax(3)*ones(1,size(score_SH,1))+noise_plot, score_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3);

    % first LH
    b1Lf = bar(x_ax(6),nanmean(first_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    % % data points
    % plot(x_ax(6)*ones(1,size(first_LH,1))+noise_plot, first_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3);

    % LH
    b1L = bar(x_ax(9),nanmean(score_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

    % % data points
    % plot(x_ax(9)*ones(1,size(score_LH,1))+noise_plot, score_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',3)

    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[score_SH(n) first_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    for n = 1:size(first_LH,1)
        lin2 = plot(x_ax([6 9])+noise_plot(n),[first_LH(n) score_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3]; % transparency
    end

    h = errorbar(x_ax([3 6 9]),...
        [nanmean(score_SH) nanmean(first_LH) nanmean(score_LH)], ...
        [nanstd(score_SH)./sqrt(size(score_SH,1)) nanstd(first_LH)./sqrt(size(score_SH,1)) nanstd(score_LH)./sqrt(size(score_SH,1))],'.','color','k');

    set(h,'Marker','none')

    xlim([0.15 3.85])   
    set(gca,'XTick',[x_ax(3) x_ax(6) x_ax(9)])

    labels = {strcat('Short horizon \newline',32,32,'1st sample'),strcat(' Long horizon \newline',32,32,' 1st sample'),strcat(32,32,32,32,'Long horizon \newline',32,32,'average sample')};
    a = gca;
    a.XTickLabel = labels;

    ylabel('Reward','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',4.9:0.3:7)
    ylim([min(min(score(:,2:4)))-0.1 max(max(score(:,2:4)))+0.1])


    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_behaviour_score.tif'],'-nocrop','-r200')
end