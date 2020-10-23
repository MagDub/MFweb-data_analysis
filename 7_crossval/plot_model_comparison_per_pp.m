
%% Data
load('model_selection.mat')
load('mean_all_pp.mat')

% for model = 1:size(mod.mean_pp,2)
%     all_models(model,:) = mod.mean_pp{model}';
% end

all_models = mean_all_pp';

mean_per_model = nanmean(all_models');

% [~,index_best_models] = sort(mean_per_model, 'descend');
% best_3_models = index_best_models(1:3);

%% Figure

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

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];

x = 1:size(all_models,1)+2;
x =[x(1:1+3), x(6:6+3), x(11:11+3)];

[highest_acc_pp,best_model_ind_pp] = max(all_models,[],1);

[val]=hist(best_model_ind_pp,1:1:size(mod.mean_pp,2));

b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;

txt_val = val';
ind_notnul = find(val~=0);

text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
box off

ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
set(gca,'YTick',0:10:100)
ylim([0 25])

xticks(1:size(all_models,1)+2);
xticklabels([legend_all(1:1+3),{''}, legend_all(5:5+3),{''},legend_all(9:9+3)]);
xlim([0,size(all_models,1)+3])

xtickangle(45)

% legend([bw c],{'Winning model'}, 'Position',[0.510570545087122 0.877599978724319 0.361878446452526 0.0666666650981234]);
% legend boxoff  

hold off


% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_model_comparison_CV_pp.png'],'-nocrop','-r200')


