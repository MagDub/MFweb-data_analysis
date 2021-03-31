function [] = render_bandit_means(title_, data_, xlabels_, ylabel_)


    n = size(data_,1);
    
    col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
    col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

    %mean
    bar(1:3, nanmean(data_), 'FaceColor',col_(1,:)); hold on;

    % individual dots
    noise_plot = (rand(1,n)-0.5)/3;
    plot(1*ones(1,n)+noise_plot, data_(:,1),'.','MarkerSize',0.5,'MarkerEdgeColor',col_(2,:)); hold on;
    plot(2*ones(1,n)+noise_plot, data_(:,2),'.','MarkerSize',0.5,'MarkerEdgeColor',col_(2,:)); hold on;
    plot(3*ones(1,n)+noise_plot, data_(:,3),'.','MarkerSize',0.5,'MarkerEdgeColor',col_(2,:)); hold on;
    
    box off;
    
    h = errorbar(1:3, nanmean(data_), nanstd(data_)./sqrt(n),'.','color','k');

    set(h,'Marker','none')
    
    title(title_,'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');
    
    ylim([1 10]);
    
    ylabel(ylabel_','FontName','Arial','Fontweight','bold','FontSize',12);
    
    xticklabels(xlabels_)
    xlabel('Present bandits','FontName','Arial','Fontweight','bold','FontSize',12);
    xtickangle(45);


end

