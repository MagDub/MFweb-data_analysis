
load('../../data/data_for_figs/mod.mat')
load('../../data/data_for_figs/mean_all_pp.mat')

mean_all_pp(4,:) = nan(1,12);
mean_all_pp(32,:) = nan(1,12);
mean_all_pp(36,:) = nan(1,12);

mean_all = [];

for model = 1:12
    
    mod.mean_all{model} = nanmean(mean_all_pp(:,model));
    mod.stderror_all{model} = nanstd(mean_all_pp(:,model)) / sqrt(mod.number_par{model});
    
    mean_all(model) = mod.mean_all{model};
    stderror_all(model) = mod.stderror_all{model};
    
    number_par_all(model) = mod.number_par{model};
    
end

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];
col_(3,:) = [0.674509823322296 0.423529416322708 0.423529416322708];


x = [1:4 6:9 11:14];

I = 1:1:size(mean_all,2); 

bar(x,mean_all(I)*100,'FaceColor',col_(1,:), 'FaceAlpha', 1); hold on;
bw = bar(x(4),mean_all(4)*100,'FaceColor',col_(2,:), 'FaceAlpha', 1, 'BarWidth',0.8); hold on;

legend([bw],{'Winning model'}, 'Position',[0.510570545087122 0.877599978724319 0.361878446452526 0.0666666650981234]);
legend boxoff  

noise_plot = (rand(65,1)-0.5)/4;

% data points
% plot(x.*ones(65,1)+noise_plot, mean_all_pp*100,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2); hold on;

er = errorbar(x,mean_all(I)*100,stderror_all(I)*100,stderror_all(I)*100);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
% title('10-fold crossvalidation performance per model')
ylabel('Held-out data likelihood [%]')
yrange = [48 56]; %grid on;
% yrange = [min(min(mean_all_pp*100)) max(max(mean_all_pp*100))];
ylim(yrange)
xticks(x)
xticklabels(legend_all(I));
xtickangle(45)
set(gca,'YTick',0:2:100)

% for i1=1:size(mean_all,2)
%     text(x(i1),yrange(1) + 0.01*100,num2str(number_par_all(I(i1))),...
%                'HorizontalAlignment','center',...
%                'VerticalAlignment','bottom')
%    text(x(i1),yrange(1) + 0.025*100,'n= ',...
%                'HorizontalAlignment','center',...
%                'VerticalAlignment','bottom')
% end

hold off

nanmean(mean_all_pp(:,[4,8,12]))*100
mean_all(:,[4,8,12])*1000

save('model_selection.mat', 'mod')
save('mean_all_pp.mat', 'mean_all_pp')

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_model_comparison_CV.png'],'-nocrop','-r200')