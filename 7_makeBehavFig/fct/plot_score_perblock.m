
data_fold = ('../../data/');

load(strcat(data_fold, 'data_for_figs/score_desc.mat'))
load('../usermat_completed.mat')

b1=load(strcat(data_fold, 'data_for_figs/score_block1.mat'));
b2=load(strcat(data_fold, 'data_for_figs/score_block2.mat'));
b3=load(strcat(data_fold, 'data_for_figs/score_block3.mat'));
b4=load(strcat(data_fold, 'data_for_figs/score_block4.mat'));

score_SH = [b1.score(:,2), b2.score(:,2), b3.score(:,2), b4.score(:,2)];
first_LH = [b1.score(:,3), b2.score(:,3), b3.score(:,3), b4.score(:,3)];
score_LH = [b1.score(:,4), b2.score(:,4), b3.score(:,4), b4.score(:,4)];

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
score_SH(to_del,:) = nan;
score_LH(to_del,:) = nan;
first_LH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:10;

noise_plot = (rand(size(score_SH,1),1)-0.5)/5;

% SH
b1S= bar(x_ax([3,4,5,6]),nanmean(score_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1); 

% first LH
b1Lf = bar(x_ax([8,9,10,11]),nanmean(first_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);

% LH
b1L = bar(x_ax([13,14,15,16]),nanmean(score_LH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);


h = errorbar(x_ax([3 4 5 6 8 9 10 11 13 14 15 16]),...
    [nanmean(score_SH) nanmean(first_LH) nanmean(score_LH)], ...
    [nanstd(score_SH)./sqrt(size(score_SH,1)) nanstd(first_LH)./sqrt(size(score_SH,1)) nanstd(score_LH)./sqrt(size(score_SH,1))],'.','color','k');

set(h,'Marker','none')

xlim([0.15 6.6])   
set(gca,'XTick',[   (x_ax(4)+x_ax(5))/2    (x_ax(9)+x_ax(10))/2    (x_ax(14)+x_ax(15))/2   ])

labels = {strcat('Short horizon \newline',32,32,'1st sample'),strcat(' Long horizon \newline',32,32,' 1st sample'),strcat(32,32,32,32,'Long horizon \newline',32,32,'average sample')};
a = gca;
a.XTickLabel = labels;

ylabel('Reward','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:0.1:7)
ylim([5.65 6.15])

 
% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_score_perBlock.tif'],'-nocrop','-r200')