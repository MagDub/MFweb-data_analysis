
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

subplot(2,2,1)
letter_ = 'a';
title_ = {'Certain, standard, novel'};
ylabel_ = {''};
position_ = [0.16 0.79 0.2 0.13];
render_fig_all('ABC', title_, ylabel_, letter_, position_); 

subplot(2,2,2)
letter_ = 'b';
title_ = {'Certain, standard, low'};
ylabel_ = {''};
position_ = [0.60 0.79 0.2 0.13];
render_fig_all('ABD', title_, ylabel_, letter_, position_);  
 
subplot(2,2,3)
letter_ = 'c';
title_ = {'Certain, novel, low'};
ylabel_ = {''};
position_ = [0.16 0.32 0.2 0.13];
render_fig_all('ACD', title_, ylabel_, letter_, position_);   

subplot(2,2,4)
letter_ = 'd';
title_ = {'Standard, novel, low'};
ylabel_ = {''};
position_ = [0.60 0.32 0.2 0.13];
render_fig_all('BCD', title_, ylabel_, letter_, position_);   
 
% Export
addpath('../../../export_fig')
export_fig(['./Fig/Fig_Values_all.tif'],'-nocrop','-r200')