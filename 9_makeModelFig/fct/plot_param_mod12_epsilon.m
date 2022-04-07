
function [] = plot_param_mod12_epsilon(to_del)

    % Data
    load('./data_for_figs_2/model_parameters.mat')
    load('./data_for_figs_2/model_parameters_desc.mat')
    ind_SH = find(contains(model_parameters_desc,'xi_short'));
    ind_LH = find(contains(model_parameters_desc,'xi_long'));
    param_SH = model_parameters(:,ind_SH);
    param_LH = model_parameters(:,ind_LH);

    xi_SH = param_SH;
    xi_LH = param_LH;
    save('../../data/data_for_figs/mod12_xi_SH.mat', 'xi_SH')
    save('../../data/data_for_figs/mod12_xi_LH.mat', 'xi_LH')

    load('../usermat_completed.mat')

    % Remove ID
    param_SH(to_del,:) = [];
    param_LH(to_del,:) = [];

    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:4;

    noise_plot = (rand(size(model_parameters,1),1)-0.5)/5;

    % Short horizon
    b2S = bar(x_ax(3),nanmean(param_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
    % plot(x_ax(3)*ones(1,size(param_SH,1)), param_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    % Long horizon
    b2L = bar(x_ax(6),nanmean(param_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
    % plot(x_ax(6)*ones(1,size(param_LH,1)), param_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    for n = 1:size(param_SH,1)
        lin2 = plot(x_ax([3 6])+noise_plot(n),[param_SH(n) param_LH(n)]); hold on;
        lin2.Color = [col_(2,:) 0.3];
    end

    h = errorbar(x_ax([3 6]),[nanmean(param_SH) nanmean(param_LH)], ...
        [nanstd(param_SH)./sqrt(size(param_SH,1)) nanstd(param_LH)./sqrt(size(param_SH,1))],'.','color','k');
    set(h,'Marker','none')

    xlim([0 2.8])
    set(gca,'XTick',[x_ax(3) x_ax(6)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon'};

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:0.2:1)
    ylim([0 1])

    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_param_epsilon.tif'],'-nocrop','-r200')
    
end