
data_fold = ('../../data/');

n_trials_perhor = 200;

% Data
b1=load(strcat(data_fold, 'data_for_figs/chosenOption_B1.mat'));
b2=load(strcat(data_fold, 'data_for_figs/chosenOption_B2.mat'));
b3=load(strcat(data_fold, 'data_for_figs/chosenOption_B3.mat'));
b4=load(strcat(data_fold, 'data_for_figs/chosenOption_B4.mat'));

pickedhigh_SH = [(b1.chosenOption.ABD.freq(:,1)+b1.chosenOption.AB.freq(:,1)+b1.chosenOption.BD.freq(:,1)+b1.chosenOption.AD.freq(:,1))*100/n_trials_perhor, ...
                    (b2.chosenOption.ABD.freq(:,1)+b2.chosenOption.AB.freq(:,1)+b2.chosenOption.BD.freq(:,1)+b2.chosenOption.AD.freq(:,1))*100/n_trials_perhor, ...
                    (b3.chosenOption.ABD.freq(:,1)+b3.chosenOption.AB.freq(:,1)+b3.chosenOption.BD.freq(:,1)+b3.chosenOption.AD.freq(:,1))*100/n_trials_perhor, ...
                    (b4.chosenOption.ABD.freq(:,1)+b4.chosenOption.AB.freq(:,1)+b4.chosenOption.BD.freq(:,1)+b4.chosenOption.AD.freq(:,1))*100/n_trials_perhor];

pickedhigh_LH = [(b1.chosenOption.ABD.freq(:,4)+b1.chosenOption.AB.freq(:,4)+b1.chosenOption.BD.freq(:,4)+b1.chosenOption.AD.freq(:,4))*100/n_trials_perhor, ...
                    (b2.chosenOption.ABD.freq(:,4)+b2.chosenOption.AB.freq(:,4)+b2.chosenOption.BD.freq(:,4)+b2.chosenOption.AD.freq(:,4))*100/n_trials_perhor, ...
                    (b3.chosenOption.ABD.freq(:,4)+b3.chosenOption.AB.freq(:,4)+b3.chosenOption.BD.freq(:,4)+b3.chosenOption.AD.freq(:,4))*100/n_trials_perhor, ...
                    (b4.chosenOption.ABD.freq(:,4)+b4.chosenOption.AB.freq(:,4)+b4.chosenOption.BD.freq(:,4)+b4.chosenOption.AD.freq(:,4))*100/n_trials_perhor];

save('./frequencies/pickedhigh_SH_perB.mat', 'pickedhigh_SH')
save('./frequencies/pickedhigh_LH_perB.mat', 'pickedhigh_LH')

save('../../data/data_for_figs/pickedhigh_SH_perB.mat', 'pickedhigh_SH')
save('../../data/data_for_figs/pickedhigh_LH_perB.mat', 'pickedhigh_LH')

load('../usermat_completed.mat')

% Remove ID
to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);
pickedhigh_SH(to_del,:) = nan;
pickedhigh_LH(to_del,:) = nan;

% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col_(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002];
col_(2,:) = [0.584313750267029 0.388235300779343 0.388235300779343];

x_ax = 0:0.4:4;

noise_plot = (rand(size(pickedhigh_SH))-0.5)/5;

% Short horizon
b2S = bar(x_ax([3,4,5,6]),nanmean(pickedhigh_SH),'FaceColor',col_(1,:), 'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([3,4,5,6]).*ones(size(pickedhigh_SH))+noise_plot, pickedhigh_SH,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

% Long horizon
b2L = bar(x_ax([8,9,10,11]),nanmean(pickedhigh_LH),'FaceColor',col_(1,:),'FaceAlpha', 1, 'BarWidth',1);
plot(x_ax([8,9,10,11]).*ones(size(pickedhigh_LH))+noise_plot, pickedhigh_LH,'.','MarkerEdgeColor',col_(2,:), 'MarkerSize',2);

h = errorbar(x_ax([3 4 5 6 8 9 10 11]),[nanmean(pickedhigh_SH) nanmean(pickedhigh_LH)], ...
    [nanstd(pickedhigh_SH)./sqrt(size(pickedhigh_SH,1)) nanstd(pickedhigh_LH)./sqrt(size(pickedhigh_SH,1))],'.','color','k');
set(h,'Marker','none')

xlim([0 4.8])
set(gca,'XTick',[   (x_ax(4)+x_ax(5))/2    (x_ax(9)+x_ax(10))/2  ])
a = gca;
a.XTickLabel = {'Short horizon', 'Long horizon'};

ylabel('Choice frequency [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:5:80)
ylim([0 26])

% legend([b2S b2L],{'Short horizon', 'Long horizon'});
% legend boxoff  

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_high_value_perBlock.tif'],'-nocrop','-r200')