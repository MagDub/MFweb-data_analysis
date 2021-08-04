
function [] = render_correlation_xi_ASRS_hypimp_LH(to_del)

    % Data
    load('../../data/data_for_figs/mod12_xi_LH.mat');
    xi_LH(to_del,:) = [];

    load('../usermat_completed.mat')
    load('../../data/questionnaire/all/ASRS_all.mat')
    load('../../data/questionnaire/all/ASRS_score_desc.mat')
    ASRS = ASRS_all;
    ASRS(to_del,:) = [];
    
    ASRS_hypimp=ASRS(:,7);
    
    x=ASRS_hypimp;
    y=xi_LH;

    % Plot
    cols(1,:) = [1 1 1]; 
    cols(2,:) = [0 57 94]/255; % Color chance level 
    cols(3,:) = [0.729411780834198 0.831372559070587 0.95686274766922]; 
    cols(4,:) = [0.494117647409439 0.494117647409439 0.494117647409439]; 
    
%     l = lsline ; %%% regression line
%     set(l,'LineWidth', 1.5, 'Color',cols(4,:)); hold on
    
    wh1=plot(-10,-10, 'o','MarkerFaceColor','w','MarkerEdgeColor','w'); hold on; %invisible
    wh2=plot(x,y, 'o','MarkerFaceColor','w','MarkerEdgeColor','w'); 
    
    scale = 3;
    %jitt = rand(size(x,1),1)*scale-scale/2;

    % with color code
    g1=plot(x,y, 'o','MarkerFaceColor',cols(1,:),'MarkerEdgeColor',cols(2,:),'MarkerSize',4.5, 'LineWidth', 0.7); hold on;
    ylabel({'\epsilon-greedy parameter long horizon'},'FontName','Arial','Fontweight','bold','FontSize',12);
    xlabel('ASRS hyperactivity-impulsivity','FontName','Arial','Fontweight','bold','FontSize',12);

    xlimmin=min(ASRS_hypimp);
    xlimmax=max(ASRS_hypimp);
    
    ylimmin=min(xi_LH);
    ylimmax=max(xi_LH);
    
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
