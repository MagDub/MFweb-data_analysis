function [] = render_fig_all(cond, title_, ylabel_, letter_, position_)

    % load
    load('./concat_data/desc_split.mat')
    T1=load(strcat('./concat_data/split_mat_SH_init_',cond,'.mat'));
    T2=load(strcat('./concat_data/split_mat_SH_1_',cond,'.mat'));
    T3=load(strcat('./concat_data/split_mat_LH_1_',cond,'.mat'));
    T4=load(strcat('./concat_data/split_mat_LH_26_',cond,'.mat'));

    tmp_data_1 = T1.(strcat('split_mat_SH_init_', cond));
    tmp_data_2 = T2.(strcat('split_mat_SH_1_', cond));
    tmp_data_3 = T3.(strcat('split_mat_LH_1_', cond));
    tmp_data_4 = T4.(strcat('split_mat_LH_26_', cond));
    
    data_1 = tmp_data_1(:,[1,2,5,6]);
    data_2 = tmp_data_2(:,[1,2,5,6]);
    data_3 = tmp_data_3(:,[1,2,5,6]);
    data_4 = tmp_data_4(:,[1,2,5,6]);

    n = sum(~isnan(data_1(:,1)));
    
    if n==0
        n = sum(~isnan(data_1(:,2)));
    end

    % compute
    data_mean_1 = nanmean(data_1);
    data_sd_1 = nanstd(data_1);
    data_mean_2 = nanmean(data_2);
    data_sd_2 = nanstd(data_2);
    data_mean_3 = nanmean(data_3);
    data_sd_3 = nanstd(data_3);
    data_mean_4 = nanmean(data_4);
    data_sd_4 = nanstd(data_4);

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    noise_plot = (rand(size(data_1,1),1)-0.5)/5;

    %%%
    
    b_init = bar([1,6,10,15],data_mean_1,'FaceColor',col_(1,:), 'FaceAlpha', 0, 'BarWidth',0.2); hold on;
    b_SH_1 = bar([2,7,11,16],data_mean_2,'FaceColor',col_(1,:), 'FaceAlpha', 0.35, 'BarWidth',0.2); hold on;
    b_LH_1 = bar([3,8,12,17],data_mean_3,'FaceColor',col_(1,:), 'FaceAlpha', 0.7, 'BarWidth',0.2); hold on;
    b_LH_26 = bar([4,9,13,18],data_mean_4,'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',0.2); hold on;

    blank = plot(1,100,'w*');
    
    %%%
    
    plot([1,6,10,15].*ones(size(data_1))+noise_plot, data_1, '.', 'MarkerEdgeColor', col_(2,:), 'MarkerSize',2); hold on;
    plot([2,7,11,16].*ones(size(data_2))+noise_plot, data_2, '.', 'MarkerEdgeColor', col_(2,:), 'MarkerSize',2); hold on;
    plot([3,8,12,17].*ones(size(data_3))+noise_plot, data_3, '.', 'MarkerEdgeColor', col_(2,:), 'MarkerSize',2); hold on;
    plot([4,9,13,18].*ones(size(data_4))+noise_plot, data_4, '.', 'MarkerEdgeColor', col_(2,:), 'MarkerSize',2); 

    %%%
    
    h1 = errorbar([1,6,10,15],data_mean_1, data_sd_1./sqrt(n),'.','color','k');
    set(h1,'Marker','none')
    
    h2 = errorbar([2,7,11,16],data_mean_2, data_sd_2./sqrt(n),'.','color','k');
    set(h1,'Marker','none')
    
    h3 = errorbar([3,8,12,17],data_mean_3, data_sd_3./sqrt(n),'.','color','k');
    set(h1,'Marker','none')
    
    h4 = errorbar([4,9,13,18],data_mean_4, data_sd_4./sqrt(n),'.','color','k');
    set(h1,'Marker','none')
    
    %%%

    legend([b_init, b_SH_1, b_LH_1, b_LH_26, blank], {'Initial samples', 'Short hoizon 1st choice', 'Long horizon 1st choice', 'Long horizon next choices', ''}, ...
        'Position',position_,'FontSize',9);

    legend boxoff;

    set(gca,'box','off')
    xtickangle(45);
    xticks([1:18])
    xticklabels({'High certain', '','','', '', 'High standard', '', '','','', 'Novel', '','','', 'Low'})

    xlabel('Bandit type','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel(ylabel_,'FontName','Arial','Fontweight','bold','FontSize',12);
    text(0-0.2, 1+0.23,letter_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    yticks([0:2:10])
    ylim([1,16])
    
    t=title(title_,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end

