
function [] = plot_param_mod12_Q0(to_del)

    % Data
    load('./data_for_figs_2/model_parameters.mat')
    load('./data_for_figs_2/model_parameters_desc.mat')
    ind = find(contains(model_parameters_desc,'Q0'));
    param = model_parameters(:,ind);

    Q0 = param;
    save('../../data/data_for_figs/mod12_Q0.mat', 'Q0')

    load('../usermat_completed.mat')

    % Remove ID
    param(to_del,:) = nan;

    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = [1];

    noise_plot = (rand(size(model_parameters,1),1)-0.5)/3;

    b2S = bar(x_ax(1),nanmean(param),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',.5);
    plot(x_ax(1)*ones(1,size(param,1))+noise_plot, param','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',4);

    h = errorbar(x_ax,[nanmean(param)], ...
        [nanstd(param)./sqrt(size(param,1))],'.','color','k');
    set(h,'Marker','none')

    xlim([x_ax(1)-0.75 x_ax(1)+0.75])   
    set(gca,'XTick',[mean(x_ax)])
    set(gca,'XTickLabel',{''});

    ylabel('Best-fit parameter value','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:2:10)
    ylim([0 6.2])

    % Export
    addpath('../../export_fig')
    export_fig(['./fig/Fig_param_Q0.tif'],'-nocrop','-r200')
end
