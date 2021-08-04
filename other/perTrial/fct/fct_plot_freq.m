function [] = fct_plot_freq(n_trials, data_, beta_, title_, letter_, loc_, ylim_, index_, height_stats_)

    a = plot(1:n_trials, data_, 'o'); hold on;
    p_m = plot(1:n_trials, data_(end)*ones(1,n_trials), 'r:'); hold on;
    
    intercept_ = nanmean(beta_(1,:));
    slope_ = nanmean(beta_(2,:));
    x = 1:n_trials;
    p_lr = plot(x, intercept_+slope_*x, 'b-');
    
    % stats
    slopes_all = beta_(2,:)';
    [~,p,~,~] = ttest(slopes_all);
    if p<0.001
        txt_ = {strcat('$\bar{\beta_1}$=', num2str(slope_,2));'p$<$0.001'};
    else
        txt_ = {strcat('$\bar{\beta_1}$=', num2str(slope_,2));strcat('p=', num2str(p,2))};
    end
    
    text(0.6, height_stats_,txt_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 12, 'Interpreter','Latex')
    legend([p_m, p_lr], {'total (= on last trial)', 'y = $\bar{\beta_0}$ + $\bar{\beta_1}*x$'}, 'Location', loc_, 'Interpreter','Latex','FontSize', 12); 
    legend boxoff;
    box off;
    
    ylabel('Frequency','FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('Trial','FontName','Arial','Fontweight','bold','FontSize',12);
    
    yticks(0:index_:100)
    ylim(ylim_);
    
    xticks(0:50:200)
    xlim([0 200]);

    text(0-0.2, 1+0.25,letter_,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    t=title(title_,'FontSize', 16, 'FontName','Arial', 'Fontweight','normal');
    

    
end

