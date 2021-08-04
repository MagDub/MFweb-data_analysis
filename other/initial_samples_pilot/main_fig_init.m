
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(1,4,1)
letter_ = 'a';
title_ = {'Certain standard, ',' standard, novel'};
render_fig_initial_samples('ABC', title_, letter_); 

subplot(1,4,2)
letter_ = 'b';
title_ = {'Certain standard, ',' standard, low'};
render_fig_initial_samples('ABD', title_, letter_);

subplot(1,4,3)
letter_ = 'c';
title_ = {'Certain standard, ',' novel, low'};
render_fig_initial_samples('ACD', title_, letter_);

subplot(1,4,4)
letter_ = 'd';
title_ = {'Standard, ',' novel, low'};
render_fig_initial_samples('BCD', title_, letter_);

% Export
addpath('../../../export_fig')
export_fig(['./Fig/Fig_Values_InitialSamples.tif'],'-nocrop','-r200')
