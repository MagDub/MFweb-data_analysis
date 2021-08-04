
function [] = plot_novel_value_perblock_diff(to_del)

    data_fold = ('../../data/');

    n_trials_perhor = 200;

    % Data
    b1=load(strcat(data_fold, 'data_for_figs/frequencies_B1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/frequencies_B2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/frequencies_B3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/frequencies_B4.mat'));

    pickedC_SH = [b1.frequencies(:,3)*100/n_trials_perhor, b2.frequencies(:,3)*100/n_trials_perhor, b3.frequencies(:,3)*100/n_trials_perhor, b4.frequencies(:,3)*100/n_trials_perhor];
    pickedC_LH = [b1.frequencies(:,7)*100/n_trials_perhor, b2.frequencies(:,7)*100/n_trials_perhor, b3.frequencies(:,7)*100/n_trials_perhor, b4.frequencies(:,7)*100/n_trials_perhor];

    pickedC_diff = pickedC_LH - pickedC_SH;
    
    load('../usermat_completed.mat')

    % Remove ID
    pickedC_diff(to_del,:) = nan;

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:10;
    
    x_ticks_ = [(x_ax(3)+x_ax(4))/2 (x_ax(6)+x_ax(7))/2  (x_ax(9)+x_ax(10))/2 (x_ax(12)+x_ax(13))/2];

    noise_plot = (rand(size(pickedC_diff))-0.5)/10;

    b2S = plot(x_ticks_,nanmean(pickedC_diff),'Color',col_(2,:));  hold on;
    
    % error bars
    h = errorbar(x_ticks_,nanmean(pickedC_diff), ...
        [nanstd(pickedC_diff)./sqrt(size(pickedC_diff,1))],'.','color','k');
    set(h,'Marker','none')
    
    xlim([0 5.6])
    set(gca,'XTick',x_ticks_)
    a = gca;
    a.XTickLabel = {'1', '2', '3', '4'};

    xlabel('Block','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel('Difference (LH-SH)','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',-10:0.5:80)
    ylim([1.5 3])

    box off;
    
    title('Novel bandit','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end