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
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
% set(gca,'FontName','Arial','FontSize',10)
% hold on;
% 
% subplot(1,3,1)
% render_correlation_xi_BIS(to_del)
% 
% subplot(1,3,2)
% render_correlation_xi_BIS_SH(to_del)
% 
% subplot(1,3,3)
% render_correlation_xi_BIS_LH(to_del)
% 
% % Export
% addpath('../../export_fig')
% export_fig(['Fig_corr_xi_BIS.png'],'-nocrop','-r200')

    


%%% ASRS

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

render_correlation_xi_ASRS(to_del)

% Export
addpath('../../export_fig')
export_fig(['Fig_corr_xi_ASRS.png'],'-nocrop','-r200')




% %%% ASRS inattention
% 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
% set(gca,'FontName','Arial','FontSize',10)
% hold on;
% 
% render_correlation_xi_ASRS_inat(to_del)
% 
% % Export
% addpath('../../export_fig')
% export_fig(['Fig_corr_xi_ASRS_inat.png'],'-nocrop','-r200')
%     
% 
% 
% %%% ASRS hypimp
% 
% figure('Color','w');
% set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
% set(gca,'FontName','Arial','FontSize',10)
% hold on;
% 
% subplot(1,3,1)
% render_correlation_xi_ASRS_hypimp(to_del)
% 
% subplot(1,3,2)
% render_correlation_xi_ASRS_hypimp_SH(to_del)
% 
% subplot(1,3,3)
% render_correlation_xi_ASRS_hypimp_LH(to_del)
% 
% 
% % Export
% addpath('../../export_fig')
% export_fig(['Fig_corr_xi_ASRS_hypimp.png'],'-nocrop','-r200')
    
    
    