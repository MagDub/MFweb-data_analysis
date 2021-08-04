

function [] = plot_low_value_perblock_2(to_del)

    data_fold = ('../../data/');

    n_trials_perhor = 200;

    % Data
    b1=load(strcat(data_fold, 'data_for_figs/frequencies_B1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/frequencies_B2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/frequencies_B3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/frequencies_B4.mat'));

    pickedD_SH = [b1.frequencies(:,4)*100/n_trials_perhor, b2.frequencies(:,4)*100/n_trials_perhor, b3.frequencies(:,4)*100/n_trials_perhor, b4.frequencies(:,4)*100/n_trials_perhor];
    pickedD_LH = [b1.frequencies(:,8)*100/n_trials_perhor, b2.frequencies(:,8)*100/n_trials_perhor, b3.frequencies(:,8)*100/n_trials_perhor, b4.frequencies(:,8)*100/n_trials_perhor,];

%     save('./frequencies/pickedD_SH_perB.mat', 'pickedD_SH')
%     save('./frequencies/pickedD_LH_perB.mat', 'pickedD_LH')
% 
%     save('../../data/data_for_figs/pickedD_SH_perB.mat', 'pickedD_SH')
%     save('../../data/data_for_figs/pickedD_LH_perB.mat', 'pickedD_LH')

    load('../usermat_completed.mat')

    % Remove ID
    pickedD_SH(to_del,:) = nan;
    pickedD_LH(to_del,:) = nan;

    % Figure
    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0.5:0.5:10;

    all_SH = nanmean(pickedD_SH,2);
    all_LH = nanmean(pickedD_LH,2);

    n_=nnz(~isnan(all_SH));

    pickedD_all = (pickedD_SH + pickedD_LH)/2;

    noise_plot = (rand(size(pickedD_SH))-0.5)/5;
    noise_plot_concat = (rand(size(all_SH))-0.5)/5;

    % Short horizon
    b_SH= bar(x_ax(1),nanmean(all_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',0.5); hold on;
    plot(x_ax(1)*ones(1,size(all_SH,1))+noise_plot_concat, all_SH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2); 

    % Long horizon
    b_LH= bar(x_ax(2),nanmean(all_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',0.5); hold on;
    plot(x_ax(2)*ones(1,size(all_LH,1))+noise_plot_concat, all_LH','.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2); 

    % Dashed line
    y_dashed = 0:10:100;
    plot(x_ax(3)*ones(size(y_dashed)),y_dashed,'k--', 'MarkerSize',2);

    % Blocks
    b_block= bar(x_ax([4,5,6,7]),nanmean(pickedD_all),'FaceColor',col_(1,:), 'FaceAlpha', 0.25, 'BarWidth',1); hold on;
    plot(x_ax([4,5,6,7]).*ones(size(pickedD_all))+noise_plot, pickedD_all,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

    % Error bars
    h = errorbar(x_ax([1 2 4 5 6 7]),...
        [nanmean(all_SH) nanmean(all_LH) nanmean(pickedD_all)], ...
        [nanstd(all_SH)./sqrt(n_) nanstd(all_SH)./sqrt(n_) nanstd(pickedD_all)./sqrt(n_)],'.','color','k');
    set(h,'Marker','none')

    xlim([0 4])
    set(gca,'XTick',[x_ax(1), x_ax(2), x_ax(4), x_ax(5), x_ax(6), x_ax(7)])
    a = gca;
    a.XTickLabel = {'Short horizon', 'Long horizon', 'Block 1', 'Block 2', 'Block 3', 'Block 4'};
    xtickangle(45)

    ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:2:80)
    max_ = max([pickedD_SH(:); pickedD_LH(:); pickedD_all(:)]);
    ylim([0 max_])

    legend boxoff  

end
