
load('mle_mat_all_extended.mat')

n_model = size(mle_mat_all,2);

mle_mat_all(4,:) = nan(1,n_model);
mle_mat_all(32,:) = nan(1,n_model);
mle_mat_all(36,:) = nan(1,n_model);

BIC_all = 2*mle_mat_all + log(400).*[3, 5, 5, 7,    9, 9, 9, 9]; %mle is NLL

[highest_acc_pp,best_model_ind_pp] = min(BIC_all,[],2);
[val]=hist(best_model_ind_pp,1:1:n_model);

% Legend
legend_all{1} = 'thompson';
legend_all{2} = 'thompson + \epsilon'; 
legend_all{3} = 'thompson + \eta';
legend_all{4} = 'thompson + \eta + \epsilon'; 
legend_all{5} = 'thompson + \eta + \eta_B + \epsilon';
legend_all{6} = 'thompson + \eta + \eta_T + \epsilon';
legend_all{7} = 'thompson + \eta + \epsilon + \epsilon_B' ;
legend_all{8} = 'thompson + \eta + \epsilon + \epsilon_T';

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];

x = 1:n_model+2;
x =[x(1:1+3), x(6:6+3)];

b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;

txt_val = val';
ind_notnul = find(val~=0);

text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
box off

ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
set(gca,'YTick',0:10:100)
ylim([0  39])

xticks(x);
xticklabels([legend_all(1:4), legend_all(5:8)]);
xlim([0,n_model+3])

xtickangle(45)

% % Export
% addpath('../../export_fig')
% export_fig(['./fig/Fig_model_comparison_BIC_per_pp_extended.png'],'-nocrop','-r200')