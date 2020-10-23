clear;

%% Data
load('model_selection.mat')
load('mean_all_pp.mat')

% for model = 1:size(mod.mean_pp,2)
%     all_models(model,:) = mod.mean_pp{model}';
% end

tmp_mean_all_pp = mean_all_pp(any(~isnan(mean_all_pp),2),:); %remove nan
all_models = tmp_mean_all_pp';

mean_per_model = nanmean(all_models');

[~,index_best_models] = sort(mean_per_model, 'descend');

n_mod = 3;

best_models = index_best_models(1:n_mod);
models = sort(best_models);

%% Figure

legend_all{1} = 'thompson';
legend_all{2} = 'thompson + \epsilon';
legend_all{3} = 'thompson + \eta';
legend_all{4} = 'thompson + \epsilon + \eta';

legend_all{5} = 'UCB';
legend_all{6} = 'UCB + \epsilon';
legend_all{7} = 'UCB + \eta';
legend_all{8} = 'UCB + \epsilon + \eta';

legend_all{9} =  'hybrid';
legend_all{10} = 'hybrid + \epsilon';
legend_all{11} = 'hybrid + \eta';
legend_all{12} = 'hybrid + \epsilon + \eta';

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];

x = 1:n_mod;

[clos,best_model_ind_pp] = max(all_models(models,:),[],1);

[val]=hist(best_model_ind_pp,1:1:n_mod);

b = bar(x,val,'FaceColor',col_(1,:),'BarWidth',.7);  hold on;

txt_val = val';
ind_notnul = find(val~=0);

text(x(ind_notnul),val(ind_notnul),num2str(txt_val(ind_notnul)),'vert','bottom','horiz','center'); 
box off

ylabel('Number of subjects','FontName','Arial','Fontweight','bold','FontSize',11);
set(gca,'YTick',0:15:100)
ylim([0 40])

models = sort(best_models);

xticks(1:0.5:size(models,2));
xticklabels([legend_all(models(1)),...
                {''}, legend_all(models(2)),...
                {''}, legend_all(models(3)),...
%                 {''}, legend_all(models(4)),...
%                 {''}, legend_all(models(5)),...
%                 {''}, legend_all(models(6)),...
%                 {''}, legend_all(models(7)),...
%                 {''}, legend_all(models(8)),...
%                 {''}, legend_all(models(9)),...
%                 {''}, legend_all(models(10)),...
                ]);
xlim([0,size(models,2)+1])

xtickangle(45)

% legend([bw c],{'Winning model'}, 'Position',[0.510570545087122 0.877599978724319 0.361878446452526 0.0666666650981234]);
% legend boxoff  

hold off


% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_model_comparison_CV_pp_3.png'],'-nocrop','-r200')

