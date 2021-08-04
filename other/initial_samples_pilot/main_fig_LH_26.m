
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

horizon = 'LH';
choice_No = '26';

subplot(1,4,1)
letter_ = 'a';
title_ = {'Certain standard, ',' standard, novel'};
ylabel_ = {'Long horizon','next choices'' size'};
render_fig_choices('ABC', horizon, choice_No, title_, ylabel_, letter_); 

subplot(1,4,2)
letter_ = 'b';
title_ = {'Certain standard, ',' standard, novel'};
ylabel_ = {'Long horizon','next choices'' size'};
render_fig_choices('ABD', horizon, choice_No, title_, ylabel_, letter_); 

subplot(1,4,3)
letter_ = 'c';
title_ = {'Certain standard, ',' standard, novel'};
ylabel_ = {'Long horizon','next choices'' size'};
render_fig_choices('ACD', horizon, choice_No, title_, ylabel_, letter_); 

subplot(1,4,4)
letter_ = 'd';
title_ = {'Certain standard, ',' standard, novel'};
ylabel_ = {'Long horizon','next choices'' size'};
render_fig_choices('BCD', horizon, choice_No, title_, ylabel_, letter_); 

% Export
addpath('../../../export_fig')
export_fig(['./Fig/Fig_Values_',horizon,'_NextChoices.tif'],'-nocrop','-r200')
