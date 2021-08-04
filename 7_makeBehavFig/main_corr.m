addpath('./fct/')

load('../usermat_completed.mat')
load('../6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% %%% BIS
% 
%     figure('Color','w');
%     set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
%     set(gca,'FontName','Arial','FontSize',10)
%     hold on;
% 
%     render_correlation_low_BIS(to_del)
% 
%     % Export
%     addpath('../../export_fig')
%     export_fig(['Fig_corr_low_BIS.png'],'-nocrop','-r200')


%%% ASRS

    figure('Color','w');
    set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
    set(gca,'FontName','Arial','FontSize',10)
    hold on;

    render_correlation_low_ASRS(to_del)

    % Export
    addpath('../../export_fig')
    export_fig(['Fig_corr_low_ASRS.png'],'-nocrop','-r200')


% %%% ASRS inattention
% 
%     figure('Color','w');
%     set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
%     set(gca,'FontName','Arial','FontSize',10)
%     hold on;
% 
%     render_correlation_low_ASRS_inat(to_del)
% 
%     % Export
%     addpath('../../export_fig')
%     export_fig(['Fig_corr_low_ASRS_inat.png'],'-nocrop','-r200')
%     
% %%% ASRS inattention
% 
%     figure('Color','w');
%     set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
%     set(gca,'FontName','Arial','FontSize',10)
%     hold on;
% 
%     render_correlation_low_ASRS_hypimp(to_del)
% 
%     % Export
%     addpath('../../export_fig')
%     export_fig(['Fig_corr_low_ASRS_hypimp.png'],'-nocrop','-r200')
    
    
    