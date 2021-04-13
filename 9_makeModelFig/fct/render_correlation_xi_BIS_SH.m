
function [] = render_correlation_xi_BIS_SH(to_del)

    % Data
    load('../../data/data_for_figs/mod12_xi_SH.mat');
    xi_SH(to_del,:) = [];

    load('../usermat_completed.mat')
    load('../../data/questionnaire/all/BIS11_all.mat')
    BIS11 = BIS11_all;
    BIS11(to_del,:) = [];
        
    x=BIS11;
    y=xi_SH;

    % Plot
    cols(1,:) = [1 1 1]; 
    cols(2,:) = [0 57 94]/255; % Color chance level 
    cols(3,:) = [0.729411780834198 0.831372559070587 0.95686274766922]; 
    cols(4,:) = [0.494117647409439 0.494117647409439 0.494117647409439]; 

    wh1=plot(-10,-10, 'o','MarkerFaceColor','w','MarkerEdgeColor','w'); hold on; %invisible
    wh2=plot(x,y, 'o','MarkerFaceColor','w','MarkerEdgeColor','w'); 
    
%     l = lsline ; %%% regression line
%     set(l,'LineWidth', 1.5, 'Color',cols(4,:)); hold on
    
    scale = 3;
    %jitt = rand(size(x,1),1)*scale-scale/2;

    % with color code
    g1=plot(x,y, 'o','MarkerFaceColor',cols(1,:),'MarkerEdgeColor',cols(2,:),'MarkerSize',4.5, 'LineWidth', 0.7); hold on;
    ylabel({'\epsilon-greedy parameter short horizon'},'FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('BIS score','FontName','Arial','Fontweight','bold','FontSize',12);

    xlimmin=min(BIS11);
    xlimmax=max(BIS11);
    
    ylimmin=min(xi_SH);
    ylimmax=max(xi_SH);
    
    xlim([xlimmin xlimmax])
    ylim([ylimmin ylimmax])
    set(gca,'YTick',0:0.2:1)

    [rho, pval] = corr(x,y, 'rows','complete', 'Type','Pearson');


    legend([wh1,wh2],{strcat('r=', num2str(round(rho,2))), strcat('p=', num2str(round(pval,2)))}, ...
        'Location','NorthEast','FontSize',14); legend boxoff;

    % Title
    text(0-0.2, 1+0.2,'','Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)
    title({'Model parameter'},'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');


    box off;
    
end
