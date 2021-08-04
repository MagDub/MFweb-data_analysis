
function [] = plot_consistency_per_tree(to_del)

    data_fold = ('../../data/');

    % Data
    load(strcat(data_fold, 'data_for_figs/consistency_freq_per_tree_desc.mat'))
    load(strcat(data_fold, 'data_for_figs/consistency_freq_per_tree.mat'))

    % Remove ID
    consistency_freq_per_tree(to_del,:) = [];

    consist_LH_A = consistency_freq_per_tree(:,1);
    consist_SH_A = consistency_freq_per_tree(:,2);

    consist_LH_B = consistency_freq_per_tree(:,3);
    consist_SH_B = consistency_freq_per_tree(:,4);

    consist_LH_C = consistency_freq_per_tree(:,5);
    consist_SH_C = consistency_freq_per_tree(:,6);

    consist_LH_D = consistency_freq_per_tree(:,7);
    consist_SH_D = consistency_freq_per_tree(:,8);


    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 1:1:8+3;

    %% A

    % Short horizon 
    b2SA = bar(x_ax(1),nanmean(consist_SH_A),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',1);
    plot(x_ax(1)*ones(1,size(consist_SH_A,1)), consist_SH_A','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);
    % Long horizon 
    b2LA = bar(x_ax(2),nanmean(consist_LH_A),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    plot(x_ax(2)*ones(1,size(consist_LH_A,1)), consist_LH_A','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(consist_SH_A,1)
        lin2 = plot(x_ax(1:2),[consist_SH_A(n) consist_LH_A(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax(1:2),[nanmean(consist_SH_A) nanmean(consist_LH_A)], ...
        [nanstd(consist_SH_A)./sqrt(size(consist_SH_A,1)) nanstd(consist_LH_A)./sqrt(size(consist_SH_A,1))],'.','color','k');
    set(h,'Marker','none')


    %% B

    % Short horizon 
    b2SB = bar(x_ax(4),nanmean(consist_SH_B),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',1);
    plot(x_ax(4)*ones(1,size(consist_SH_B,1)), consist_SH_B','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);
    % Long horizon 
    b2LB = bar(x_ax(5),nanmean(consist_LH_B),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    plot(x_ax(5)*ones(1,size(consist_LH_B,1)), consist_LH_B','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(consist_SH_B,1)
        lin2 = plot(x_ax(4:5),[consist_SH_B(n) consist_LH_B(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax(4:5),[nanmean(consist_SH_B) nanmean(consist_LH_B)], ...
        [nanstd(consist_SH_B)./sqrt(size(consist_SH_B,1)) nanstd(consist_LH_B)./sqrt(size(consist_SH_B,1))],'.','color','k');
    set(h,'Marker','none')


    %% C

    % Short horizon 
    b2SC = bar(x_ax(7),nanmean(consist_SH_C),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',1);
    plot(x_ax(7)*ones(1,size(consist_SH_C,1)), consist_SH_C','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);
    % Long horizon 
    b2LC = bar(x_ax(8),nanmean(consist_LH_C),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    plot(x_ax(8)*ones(1,size(consist_LH_C,1)), consist_LH_C','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(consist_SH_C,1)
        lin2 = plot(x_ax(7:8),[consist_SH_C(n) consist_LH_C(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax(7:8),[nanmean(consist_SH_C) nanmean(consist_LH_C)], ...
        [nanstd(consist_SH_C)./sqrt(size(consist_SH_C,1)) nanstd(consist_LH_C)./sqrt(size(consist_SH_C,1))],'.','color','k');
    set(h,'Marker','none')


    %% D

    % Short horizon 
    b2SD = bar(x_ax(10),nanmean(consist_SH_D),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',1);
    plot(x_ax(10)*ones(1,size(consist_SH_D,1)), consist_SH_D','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);
    % Long horizon 
    b2LD = bar(x_ax(11),nanmean(consist_LH_D),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    plot(x_ax(11)*ones(1,size(consist_LH_D,1)), consist_LH_D','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(consist_SH_D,1)
        lin2 = plot(x_ax(10:11),[consist_SH_D(n) consist_LH_D(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax(10:11),[nanmean(consist_SH_D) nanmean(consist_LH_D)], ...
        [nanstd(consist_SH_D)./sqrt(size(consist_SH_D,1)) nanstd(consist_LH_D)./sqrt(size(consist_SH_D,1))],'.','color','k');
    set(h,'Marker','none')

    %%

    xlim([x_ax(1)-1 x_ax(end)+1])   
    set(gca,'XTick',[1.5 4.5 7.5 10.5])
    set(gca,'XTickLabel',{'Tree A', 'Tree B', 'Tree C', 'Tree D'});

    ylabel('Proportion of same choices [%]','FontName','Arial','Fontweight','bold','FontSize',12,'Interpreter','tex');
    set(gca,'YTick',0:20:100)
    ylim([0 max(consist_LH_C)+1])

    legend([b2SA b2LA],{'Short horizon', 'Long horizon'}, 'Location', 'NorthWest');
    legend boxoff  

    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_behaviour_consistency_per_tree.tif'],'-nocrop','-r200')
end