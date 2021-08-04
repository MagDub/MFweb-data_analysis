addpath('./fct/')

load('../usermat_completed.mat')
load('../6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,3,1)
plot_high_value_perblock(to_del);

subplot(2,3,2)
plot_low_value_perblock(to_del);

subplot(2,3,3)
plot_novel_value_perblock(to_del);

subplot(2,3,4)
plot_high_value_perblock_diff(to_del);

subplot(2,3,5)
plot_low_value_perblock_diff(to_del);

subplot(2,3,6)
plot_novel_value_perblock_diff(to_del);

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_behaviour_perB.tif'],'-nocrop','-r200')


