
load('mle_mat_all_full.mat')

n_model = size(mle_mat_all,2);

mle_mat_all(4,:) = nan(1,n_model);
mle_mat_all(32,:) = nan(1,n_model);
mle_mat_all(36,:) = nan(1,n_model);

BIC_all = 2*mle_mat_all + log(400).*[3, 5, 5, 7,    5, 7, 7, 9,     8, 10, 10, 12,   9, 9, 9, 9]; %mle is NLL

[highest_acc_pp,best_model_ind_pp] = min(BIC_all,[],2);
[val]=hist(best_model_ind_pp,1:1:n_model);

% Legend
legend_all{1} = 'thompson';
legend_all{2} = 'thompson + \epsilon';
legend_all{3} = 'thompson + \eta';
legend_all{4} = 'thompson + \epsilon + \eta';

legend_all{5} = 'UCB';
legend_all{6} = 'UCB + \epsilon';
legend_all{7} = 'UCB + \eta';
legend_all{8} = 'UCB + \epsilon + \eta';

legend_all{9} = 'hybrid';
legend_all{10} = 'hybrid + \epsilon';
legend_all{11} = 'hybrid + \eta';
legend_all{12} = 'hybrid + \epsilon + \eta';

legend_all{13} = 'thompson + \eta + \eta_B + \epsilon';
legend_all{14} = 'thompson + \eta + \eta_T + \epsilon';
legend_all{15} = 'thompson + \eta + \epsilon + \epsilon_B' ;
legend_all{16} = 'thompson + \eta + \epsilon + \epsilon_T';

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];

x = 1:n_model+4;
x =[x(1:4), x(6:9), x(11:14), x(16:19)];

b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;

txt_val = val';
ind_notnul = find(val~=0);

text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
box off

ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
set(gca,'YTick',0:10:100)
ylim([0  39])

xticks(x);
xticklabels([legend_all(1:4), legend_all(5:8), legend_all(9:12), legend_all(13:16)]);
xlim([0,n_model+3])

xtickangle(45)

% % Export
% addpath('../../export_fig')
% export_fig(['./fig/Fig_model_comparison_BIC_per_pp_full.png'],'-nocrop','-r200')