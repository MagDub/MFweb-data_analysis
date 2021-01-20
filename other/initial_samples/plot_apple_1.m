
close all;

load('apple_1.mat')

avA_ = apple_1.avA;
avA = avA_(:,[2,3,4]);

avC_ = apple_1.avC;
avC = avC_(:,[1,2,4]);

avB_ = apple_1.avB;
avB = avB_(:,[1,3,4]);

avD_ = apple_1.avD;
avD = avD_(:,[1,2,3]);

% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

ylabel_ = {'1st draw','average size'};

subplot(2,2,1);
data_ = avA;
xlabels_ = {'N, L', 'S, L', 'S, N'};
title_ = 'Certain standard bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

subplot(2,2,2);
data_ = avB;
xlabels_ = {'N, L', 'CS, L', 'CS, N'};
title_ = 'Standard bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

subplot(2,2,3);
data_ = avC;
xlabels_ = {'S, L', 'CS, L', 'CS, S'};
title_ = 'Novel bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

subplot(2,2,4);
data_ = avD;
xlabels_ = {'S, N', 'CS, N', 'CS, S'};
title_ = 'Low-value bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

addpath('../../../export_fig')
export_fig(['Fig_Apple1.tif'],'-nocrop','-r200')

