
%% Data
data_NADA=load('/Users/magdadubois/MF/figures/NADA/data_for_figs/chosenOption.mat');
data_web=load('/Users/magdadubois/MF/data/data_for_figs/chosenOption.mat');
data_dev=load('/Users/magdadubois/GoogleDrive/UCL/writing/MF_dev/data_for_figs_2/chosenOption.mat');

n_trials = 200;
n_trials_dev = 48;

n_NADA = size(data_NADA.chosenOption.ABD.freq,1);
n_web = size(data_web.chosenOption.ABD.freq,1);
n_dev = size(data_dev.chosenOption.ABD.freq,1);

NADA_param_SH = (data_NADA.chosenOption.ABD.freq(:,1)+data_NADA.chosenOption.AB.freq(:,1)+data_NADA.chosenOption.BD.freq(:,1)+data_NADA.chosenOption.AD.freq(:,1))/4*100;
NADA_param_LH = (data_NADA.chosenOption.ABD.freq(:,4)+data_NADA.chosenOption.AB.freq(:,4)+data_NADA.chosenOption.BD.freq(:,4)+data_NADA.chosenOption.AD.freq(:,4))/4*100;

web_param_SH = (data_web.chosenOption.ABD.freq(:,1)+data_web.chosenOption.AB.freq(:,1)+data_web.chosenOption.BD.freq(:,1)+data_web.chosenOption.AD.freq(:,1))*100/n_trials;
web_param_LH = (data_web.chosenOption.ABD.freq(:,4)+data_web.chosenOption.AB.freq(:,4)+data_web.chosenOption.BD.freq(:,4)+data_web.chosenOption.AD.freq(:,4))*100/n_trials;

dev_param_SH = (data_dev.chosenOption.ABD.freq(:,1)+data_dev.chosenOption.AB.freq(:,1)+data_dev.chosenOption.BD.freq(:,1)+data_dev.chosenOption.AD.freq(:,1))*100/n_trials_dev;
dev_param_LH = (data_dev.chosenOption.ABD.freq(:,4)+data_dev.chosenOption.AB.freq(:,4)+data_dev.chosenOption.BD.freq(:,4)+data_dev.chosenOption.AD.freq(:,4))*100/n_trials_dev;


%% NADA Drugs
load('/Users/magdadubois/MF/figures/NADA/data_for_figs/drug_code.mat') %0: placebo, 1:amisulpride, 2:propranolol
idx_plc = find(drug_code(:,2)==0);
idx_ami = find(drug_code(:,2)==1);
idx_prop = find(drug_code(:,2)==2);

% Remove 506
NADA_param_SH(6,1) = nan;
NADA_param_LH(6,1) = nan;
n_NADA = n_NADA -1;

%% Dev age groups
load('/Users/magdadubois/GoogleDrive/UCL/writing/MF_dev/data_for_figs_2/part_num.mat')
part_num = part_num';
idx_group1 = find(part_num(1,:)<200);
idx_group2 = [find(part_num(1,:)==201) : (find(part_num(1,:)==301)-1)];
idx_group3 = [find(part_num(1,:)==301) : size(part_num,2)];

%% Figure
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 15 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on

col.groupSH(1,:) = [0.925490200519562 0.839215695858002 0.839215695858002]; 
col.groupLH(1,:) = [0.513725519180298 0.380392163991928 0.482352942228317]; 

% data points
col.dots(2,:) = [0.34901961684227 0.200000002980232 0.329411774873734];

x_ax = 0.5:0.5:10;

%% Short horizon
b1S= bar(x_ax(1+0*3),nanmean(NADA_param_SH(idx_prop)),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5); 
b2S = bar(x_ax(1+1*3),nanmean(NADA_param_SH(idx_plc)),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b3S = bar(x_ax(1+2*3),nanmean(NADA_param_SH(idx_ami)),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b4S = bar(x_ax(1+3*3),nanmean(web_param_SH),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b5S = bar(x_ax(1+4*3),nanmean(dev_param_SH(idx_group1)),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b6S = bar(x_ax(1+5*3),nanmean(dev_param_SH(idx_group2)),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b7S = bar(x_ax(1+6*3),nanmean(dev_param_SH(idx_group3)),'FaceColor',col.groupSH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);

% Short horizon data points
plot(x_ax(1+0*3)*ones(1,size(NADA_param_SH(idx_prop),1)), NADA_param_SH(idx_prop)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(1+1*3)*ones(1,size(NADA_param_SH(idx_plc),1)), NADA_param_SH(idx_plc)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(1+2*3)*ones(1,size(NADA_param_SH(idx_ami),1)), NADA_param_SH(idx_ami)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(1+3*3)*ones(1,size(web_param_SH,1)), web_param_SH','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(1+4*3)*ones(1,size(dev_param_SH(idx_group1),1)), dev_param_SH(idx_group1)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(1+5*3)*ones(1,size(dev_param_SH(idx_group2),1)), dev_param_SH(idx_group2)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(1+6*3)*ones(1,size(dev_param_SH(idx_group3),1)), dev_param_SH(idx_group3)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 

%% Long horizon
b1L= bar(x_ax(2+0*3),nanmean(NADA_param_LH(idx_prop)),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5); 
b2L = bar(x_ax(2+1*3),nanmean(NADA_param_LH(idx_plc)),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b3L = bar(x_ax(2+2*3),nanmean(NADA_param_LH(idx_ami)),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b4L = bar(x_ax(2+3*3),nanmean(web_param_LH),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b5L = bar(x_ax(2+4*3),nanmean(dev_param_LH(idx_group1)),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b6L = bar(x_ax(2+5*3),nanmean(dev_param_LH(idx_group2)),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);
b7L = bar(x_ax(2+6*3),nanmean(dev_param_LH(idx_group3)),'FaceColor',col.groupLH(1,:), 'FaceAlpha', 0.25, 'BarWidth',.5);

% Long horizon data points
plot(x_ax(2+0*3)*ones(1,size(NADA_param_LH(idx_prop),1)), NADA_param_LH(idx_prop)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(2+1*3)*ones(1,size(NADA_param_LH(idx_plc),1)), NADA_param_LH(idx_plc)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(2+2*3)*ones(1,size(NADA_param_LH(idx_ami),1)), NADA_param_LH(idx_ami)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(2+3*3)*ones(1,size(web_param_LH,1)), web_param_LH','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(2+4*3)*ones(1,size(dev_param_LH(idx_group1),1)), dev_param_LH(idx_group1)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(2+5*3)*ones(1,size(dev_param_LH(idx_group2),1)), dev_param_LH(idx_group2)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(2+6*3)*ones(1,size(dev_param_LH(idx_group3),1)), dev_param_LH(idx_group3)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 

%% Line between data points
for n = 1:size(idx_prop,1)
    lin1 = plot(x_ax(1:2),[NADA_param_SH(idx_prop(n)) NADA_param_LH(idx_prop(n))]); hold on;
    lin1.Color = [col.dots(2,:) 0.3]; % transparency
end

for n = 1:size(idx_plc,1)
    lin2 = plot(x_ax(4:5),[NADA_param_SH(idx_plc(n)) NADA_param_LH(idx_plc(n))]); hold on;
    lin2.Color = [col.dots(2,:) 0.3]; % transparency
end

for n = 1:size(idx_ami,1)
    lin3 = plot(x_ax(7:8),[NADA_param_SH(idx_ami(n)) NADA_param_LH(idx_ami(n))]); hold on;
    lin3.Color = [col.dots(2,:) 0.3]; % transparency
end

for n = 1:n_web
    lin1 = plot(x_ax(10:11),[web_param_SH(n) web_param_LH(n)]); hold on;
    lin1.Color = [col.dots(2,:) 0.3]; % transparency
end

for n = 1:size(idx_group1,2)
    lin2 = plot(x_ax(13:14),[dev_param_SH(idx_group1(n)) dev_param_LH(idx_group1(n))]); hold on;
    lin2.Color = [col.dots(2,:) 0.2]; % transparency
end

for n = 1:size(idx_group2,2)
    lin1 = plot(x_ax(16:17),[dev_param_SH(idx_group2(n)) dev_param_LH(idx_group2(n))]); hold on;
    lin1.Color = [col.dots(2,:) 0.2]; % transparency
end

for n = 1:size(idx_group3,2)
    lin3 = plot(x_ax(19:20),[dev_param_SH(idx_group3(n)) dev_param_LH(idx_group3(n))]); hold on;
    lin3.Color = [col.dots(2,:) 0.2]; % transparency
end

%% STD
h = errorbar(x_ax([1 2 4 5 7 8 10 11 13 14 16 17 19 20]),[...
    nanmean(NADA_param_SH(idx_prop)) nanmean(NADA_param_LH(idx_prop)) ...
    nanmean(NADA_param_SH(idx_plc)) nanmean(NADA_param_LH(idx_plc)) ...
    nanmean(NADA_param_SH(idx_ami)) nanmean(NADA_param_LH(idx_ami))...
    nanmean(web_param_SH) nanmean(web_param_LH)...
    nanmean(dev_param_SH(idx_group1)) nanmean(dev_param_LH(idx_group1)) ...
    nanmean(dev_param_SH(idx_group2)) nanmean(dev_param_LH(idx_group2)) ...
    nanmean(dev_param_SH(idx_group3)) nanmean(dev_param_LH(idx_group3))...
    ],[...
    nanstd(NADA_param_SH(idx_prop))./sqrt(20) nanstd(NADA_param_LH(idx_prop))./sqrt(20)...
    nanstd(NADA_param_SH(idx_plc))./sqrt(20) nanstd(NADA_param_LH(idx_plc))./sqrt(20)...
    nanstd(NADA_param_SH(idx_ami))./sqrt(19) nanstd(NADA_param_LH(idx_ami))./sqrt(19)...
    nanstd(web_param_SH)./sqrt(n_NADA) nanstd(web_param_SH)./sqrt(n_NADA)...
    nanstd(dev_param_SH(idx_group1))./sqrt(numel(idx_group1)) nanstd(dev_param_LH(idx_group1))./sqrt(numel(idx_group1))...
    nanstd(dev_param_SH(idx_group2))./sqrt(numel(idx_group2)) nanstd(dev_param_LH(idx_group2))./sqrt(numel(idx_group2))...
    nanstd(dev_param_SH(idx_group3))./sqrt(numel(idx_group3)) nanstd(dev_param_LH(idx_group3))./sqrt(numel(idx_group3))...
    ],'.','color','k');
set(h,'Marker','none')

% 
% legend([b2S b2L],{'Short horizon', 'Long horizon'}, 'Location','NorthWest');
% legend boxoff  

xlim([0 10.5])   
set(gca,'XTick',[1.5/2, 4.5/2, 7.5/2, 10.5/2, 13.5/2, 16.5/2, 19.5/2])
set(gca,'XTickLabel',{'NA','Placebo', 'DA', 'Web', '8-9','12-13', '16-17'})

ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:10:100)
ylim([0 88])

%% Export
export_fig(['Fig/Fig_high_value_bandit.tif'],'-nocrop','-r200')


