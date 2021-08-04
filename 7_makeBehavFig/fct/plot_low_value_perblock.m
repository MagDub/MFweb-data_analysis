
function [] = plot_low_value_perblock(to_del)

    data_fold = ('../../data/');

    n_trials_perhor = 200;

    % Data
    b1=load(strcat(data_fold, 'data_for_figs/frequencies_B1.mat'));
    b2=load(strcat(data_fold, 'data_for_figs/frequencies_B2.mat'));
    b3=load(strcat(data_fold, 'data_for_figs/frequencies_B3.mat'));
    b4=load(strcat(data_fold, 'data_for_figs/frequencies_B4.mat'));

    pickedD_SH = [b1.frequencies(:,4)*100/n_trials_perhor, b2.frequencies(:,4)*100/n_trials_perhor, b3.frequencies(:,4)*100/n_trials_perhor, b4.frequencies(:,4)*100/n_trials_perhor];
    pickedD_LH = [b1.frequencies(:,8)*100/n_trials_perhor, b2.frequencies(:,8)*100/n_trials_perhor, b3.frequencies(:,8)*100/n_trials_perhor, b4.frequencies(:,8)*100/n_trials_perhor,];

    % save('./frequencies/pickedD_SH_perB.mat', 'pickedD_SH')
    % save('./frequencies/pickedD_LH_perB.mat', 'pickedD_LH')
    % 
    % save('../../data/data_for_figs/pickedD_SH_perB.mat', 'pickedD_SH')
    % save('../../data/data_for_figs/pickedD_LH_perB.mat', 'pickedD_LH')

    load('../usermat_completed.mat')

    % Remove ID
    pickedD_SH(to_del,:) = nan;
    pickedD_LH(to_del,:) = nan;

    col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
    col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

    x_ax = 0:0.4:10;

    noise_plot = (rand(size(pickedD_SH))-0.5)/10;

    % Short horizon
    b2S = bar(x_ax([3,6,9,12]),nanmean(pickedD_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',0.3); hold on;
    
    % Long horizon
    b2L = bar(x_ax([4,7,10,13]),nanmean(pickedD_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',0.3);

    % error bars
    h = errorbar(x_ax([3 6 9 12 4 7 10 13]),[nanmean(pickedD_SH) nanmean(pickedD_LH)], ...
        [nanstd(pickedD_SH)./sqrt(size(pickedD_SH,1)) nanstd(pickedD_LH)./sqrt(size(pickedD_LH,1))],'.','color','k');
    set(h,'Marker','none')
    
    % lines
    for n = 1:size(pickedD_SH,1)
        lin1 = plot(x_ax([3 4])+noise_plot(n),[pickedD_SH(n,1) pickedD_LH(n,1)]); hold on;
        lin2 = plot(x_ax([6 7])+noise_plot(n),[pickedD_SH(n,2) pickedD_LH(n,2)]); hold on;
        lin3 = plot(x_ax([9 10])+noise_plot(n),[pickedD_SH(n,3) pickedD_LH(n,3)]); hold on;
        lin4 = plot(x_ax([12 13])+noise_plot(n),[pickedD_SH(n,4) pickedD_LH(n,4)]); hold on;
        
        lin1.Color = [col_(2,:) 0.1];
        lin2.Color = [col_(2,:) 0.1];
        lin3.Color = [col_(2,:) 0.1];
        lin4.Color = [col_(2,:) 0.1];
    end

    xlim([0 5.6])
    set(gca,'XTick',[   (x_ax(3)+x_ax(4))/2     (x_ax(6)+x_ax(7))/2  (x_ax(9)+x_ax(10))/2 (x_ax(12)+x_ax(13))/2  ])
    a = gca;
    a.XTickLabel = {'1', '2', '3', '4'};

    xlabel('Block','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
    set(gca,'YTick',0:2:80)
    ylim([0 max([max(pickedD_SH), max(pickedD_LH)])])

    box off;
    
    title('Low-value bandit','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

end