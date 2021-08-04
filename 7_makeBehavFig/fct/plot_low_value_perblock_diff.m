
function [] = plot_low_value_perblock_diff(to_del)

    data_fold = ('../../data/');

    n_trials_perhor = 200;

    % Data
    b1=load(strcat(data_fold, 'data_for_figs/frequencies_B1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/frequencies_B2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/frequencies_B3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/frequencies_B4.mat'));

    pickedD_SH = [b1.frequencies(:,4)*100/n_trials_perhor, b2.frequencies(:,4)*100/n_trials_perhor, b3.frequencies(:,4)*100/n_trials_perhor, b4.frequencies(:,4)*100/n_trials_perhor];
    pickedD_LH = [b1.frequencies(:,8)*100/n_trials_perhor, b2.frequencies(:,8)*100/n_trials_perhor, b3.frequencies(:,8)*100/n_trials_perhor, b4.frequencies(:,8)*100/n_trials_perhor,];

    pickedD_diff = pickedD_LH - pickedD_SH;
    
    load('../usermat_completed.mat')

    % Remove ID
    pickedD_diff(to_del,:) = nan;

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:10;
    
    x_ticks_ = [(x_ax(3)+x_ax(4))/2 (x_ax(6)+x_ax(7))/2  (x_ax(9)+x_ax(10))/2 (x_ax(12)+x_ax(13))/2];

    noise_plot = (rand(size(pickedD_diff))-0.5)/10;

    b2S = plot(x_ticks_,nanmean(pickedD_diff),'Color',col_(2,:));  hold on;
    
    % error bars
    h = errorbar(x_ticks_,nanmean(pickedD_diff), ...
        [nanstd(pickedD_diff)./sqrt(size(pickedD_diff,1))],'.','color','k');
    set(h,'Marker','none')
    
    xlim([0 5.6])
    set(gca,'XTick',x_ticks_)
    a = gca;
    a.XTickLabel = {'1', '2', '3', '4'};

    xlabel('Block','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel('Difference (LH-SH)','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:0.1:80)
    ylim([0 0.5])

    box off;
    
    title('Low-value bandit','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end