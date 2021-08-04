
function [] = plot_high_value_perblock_diff(to_del)

    data_fold = ('../../data/');

    n_trials_perhor = 200;

    % Data
    b1=load(strcat(data_fold, 'data_for_figs/chosenOption_B1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/chosenOption_B2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/chosenOption_B3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/chosenOption_B4.mat'));

    pickedhigh_SH = [(b1.chosenOption.ABD.freq(:,1)+b1.chosenOption.AB.freq(:,1)+b1.chosenOption.BD.freq(:,1)+b1.chosenOption.AD.freq(:,1))*100/n_trials_perhor, ...
                        (b2.chosenOption.ABD.freq(:,1)+b2.chosenOption.AB.freq(:,1)+b2.chosenOption.BD.freq(:,1)+b2.chosenOption.AD.freq(:,1))*100/n_trials_perhor, ...
                        (b3.chosenOption.ABD.freq(:,1)+b3.chosenOption.AB.freq(:,1)+b3.chosenOption.BD.freq(:,1)+b3.chosenOption.AD.freq(:,1))*100/n_trials_perhor, ...
                        (b4.chosenOption.ABD.freq(:,1)+b4.chosenOption.AB.freq(:,1)+b4.chosenOption.BD.freq(:,1)+b4.chosenOption.AD.freq(:,1))*100/n_trials_perhor];

    pickedhigh_LH = [(b1.chosenOption.ABD.freq(:,4)+b1.chosenOption.AB.freq(:,4)+b1.chosenOption.BD.freq(:,4)+b1.chosenOption.AD.freq(:,4))*100/n_trials_perhor, ...
                        (b2.chosenOption.ABD.freq(:,4)+b2.chosenOption.AB.freq(:,4)+b2.chosenOption.BD.freq(:,4)+b2.chosenOption.AD.freq(:,4))*100/n_trials_perhor, ...
                        (b3.chosenOption.ABD.freq(:,4)+b3.chosenOption.AB.freq(:,4)+b3.chosenOption.BD.freq(:,4)+b3.chosenOption.AD.freq(:,4))*100/n_trials_perhor, ...
                        (b4.chosenOption.ABD.freq(:,4)+b4.chosenOption.AB.freq(:,4)+b4.chosenOption.BD.freq(:,4)+b4.chosenOption.AD.freq(:,4))*100/n_trials_perhor];

    pickedhigh_diff = pickedhigh_LH - pickedhigh_SH;
    
    load('../usermat_completed.mat')

    % Remove ID
    pickedhigh_diff(to_del,:) = nan;

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:10;
    
    x_ticks_ = [(x_ax(3)+x_ax(4))/2 (x_ax(6)+x_ax(7))/2  (x_ax(9)+x_ax(10))/2 (x_ax(12)+x_ax(13))/2];

    noise_plot = (rand(size(pickedhigh_diff))-0.5)/10;

    b2S = plot(x_ticks_,nanmean(pickedhigh_diff),'Color',col_(2,:)); hold on;
    
    % error bars
    h = errorbar(x_ticks_,nanmean(pickedhigh_diff), ...
        [nanstd(pickedhigh_diff)./sqrt(size(pickedhigh_diff,1))],'.','color','k');
    set(h,'Marker','none')
    
    xlim([0 5.6])
    set(gca,'XTick',x_ticks_)
    a = gca;
    a.XTickLabel = {'1', '2', '3', '4'};

    xlabel('Block','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel('Difference (LH-SH)','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',-10:0.5:80)
    ylim([-3 -1.5])

    box off;
    
    title('High-value bandit','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end