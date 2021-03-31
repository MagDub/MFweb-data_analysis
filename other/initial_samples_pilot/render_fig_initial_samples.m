function [] = render_fig_initial_samples(cond, title_, letter_)

    % load
    load('./concat_data/desc_split.mat')
    T=load(strcat('./concat_data/split_mat_SH_init_',cond,'.mat'));

    tmp_data = T.(strcat('split_mat_SH_init_', cond));
    
    data_ = tmp_data(:,[1,2,5,6]);

    n = sum(~isnan(data_(:,1)));
    
    if n==0
        n = sum(~isnan(data_(:,2)));
    end

    % compute
    data_mean_1 = nanmean(data_);
    data_sd_1 = nanstd(data_);

    % Figure
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    noise_plot = (rand(size(data_,1),1)-0.5)/5;

    b1 = bar(1:4,data_mean_1,'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); hold on;

    plot([1:4].*ones(size(data_))+noise_plot, data_, '.', 'MarkerEdgeColor', col_(2,:), 'MarkerSize',2);

    h1 = errorbar([1:4],data_mean_1, data_sd_1./sqrt(n),'.','color','k');
    set(h1,'Marker','none')

    set(gca,'box','off')
    xtickangle(45);
    xticks([1:4])
    xticklabels({'High certain', 'High standard', 'Novel', 'Low'})

    xlabel('Bandit type','FontName','Arial','Fontweight','bold','FontSize',12);
    ylabel({'Initial samples''','size'},'FontName','Arial','Fontweight','bold','FontSize',12);
    text(0-0.2, 1+0.3,letter_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    yticks([0:2:10])
    ylim([1,10])
    
    t=title(title_,'FontSize', 14, 'FontName','Arial', 'Fontweight','normal');

end

