
%% Data
data_dev=load('/Users/magdadubois/GoogleDrive/UCL/writing/MF_dev/data_for_figs_2/model_parameters.mat');
data_NADA=load('/Users/magdadubois/MF/figures/NADA/data_for_figs/model_parameters_Q0uni.mat');
data_web=load('../../data/data_for_figs/model_parameters.mat');
web_desc=load('../../data/data_for_figs/model_parameters_desc.mat');
web_ind = find(contains(web_desc.model_parameters_desc,'Q0'));

n_NADA = size(data_NADA.model_parameters_Q0uni,1);
n_web = size(data_web.model_parameters,1);
n_dev = size(data_dev.model_parameters,1);

NADA_param = data_NADA.model_parameters_Q0uni(:,3);
web_param = data_web.model_parameters(:,web_ind);
dev_param = data_dev.model_parameters(:,4);

%% NADA Drugs
load('/Users/magdadubois/MF/figures/NADA/data_for_figs/drug_code.mat') %0: placebo, 1:amisulpride, 2:propranolol
idx_plc = find(drug_code(:,2)==0);
idx_ami = find(drug_code(:,2)==1);
idx_prop = find(drug_code(:,2)==2);

% Remove 506
NADA_param(6,1) = nan;
NADA_param(6,1) = nan;
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

col.group = [0.513725519180298 0.380392163991928 0.482352942228317]; 

% data points
col.dots(2,:) = [0.34901961684227 0.200000002980232 0.329411774873734];

x_ax = 0.5:0.5:10;

%% Long horizon
b1L= bar(x_ax(1),nanmean(NADA_param(idx_prop)),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5); 
b2L = bar(x_ax(3),nanmean(NADA_param(idx_plc)),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5);
b3L = bar(x_ax(5),nanmean(NADA_param(idx_ami)),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5);
b4L = bar(x_ax(7),nanmean(web_param),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5);
b5L = bar(x_ax(9),nanmean(dev_param(idx_group1)),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5);
b6L = bar(x_ax(11),nanmean(dev_param(idx_group2)),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5);
b7L = bar(x_ax(13),nanmean(dev_param(idx_group3)),'FaceColor',col.group, 'FaceAlpha', 0.25, 'BarWidth',.5);

% Long horizon data points
plot(x_ax(1)*ones(1,size(NADA_param(idx_prop),1)), NADA_param(idx_prop)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(3)*ones(1,size(NADA_param(idx_plc),1)), NADA_param(idx_plc)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(5)*ones(1,size(NADA_param(idx_ami),1)), NADA_param(idx_ami)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(7)*ones(1,size(web_param,1)), web_param','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(9)*ones(1,size(dev_param(idx_group1),1)), dev_param(idx_group1)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(11)*ones(1,size(dev_param(idx_group2),1)), dev_param(idx_group2)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 
plot(x_ax(13)*ones(1,size(dev_param(idx_group3),1)), dev_param(idx_group3)','.','MarkerEdgeColor',col.dots(2,:), 'MarkerSize',2); 

%% STD
h = errorbar(x_ax([1 3 5 7 9 11 13]),[...
    nanmean(NADA_param(idx_prop)) ...
    nanmean(NADA_param(idx_plc))  ...
    nanmean(NADA_param(idx_ami))  ...
    nanmean(web_param) ...
    nanmean(dev_param(idx_group1)) ...
    nanmean(dev_param(idx_group2)) ...
    nanmean(dev_param(idx_group3)) ...
    ],[...
    nanstd(NADA_param(idx_prop))./sqrt(20)...
    nanstd(NADA_param(idx_plc))./sqrt(20) ...
    nanstd(NADA_param(idx_ami))./sqrt(19) ...
    nanstd(web_param)./sqrt(n_NADA) ...
    nanstd(dev_param(idx_group1))./sqrt(numel(idx_group1))...
    nanstd(dev_param(idx_group2))./sqrt(numel(idx_group2))...
    nanstd(dev_param(idx_group3))./sqrt(numel(idx_group3))...
    ],'.','color','k');
set(h,'Marker','none')

xlim([0 7])   
set(gca,'XTick',[x_ax(1:2:13)])
set(gca,'XTickLabel',{'NA','Placebo', 'DA', 'Web', '8-9','12-13', '16-17'})

ylabel('Proportion of draws [%]','FontName','Arial','Fontweight','bold','FontSize',12);
set(gca,'YTick',0:1:10)
ylim([0.5 7.7])

%% Export
export_fig(['Fig/Fig_Q0.tif'],'-nocrop','-r200')


