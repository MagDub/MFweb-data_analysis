
close all;

load('initial_samples.mat')

avA_ = initial_samples.avA;
avA = avA_(:,[2,3,4]);

avB_ = initial_samples.avB;
avB = avB_(:,[1,3,4]);

avD_ = initial_samples.avD;
avD = avD_(:,[1,2,3]);

% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

ylabel_ = {'Initial samples','average size'};

subplot(1,3,1);
data_ = avA;
xlabels_ = {'N, L', 'S, L', 'S, N'};
title_ = 'Certain standard bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

subplot(1,3,2);
data_ = avB;
xlabels_ = {'N, L', 'CS, L', 'CS, N'};
title_ = 'Standard bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

subplot(1,3,3);
data_ = avD;
xlabels_ = {'S, N', 'CS, N', 'CS, S'};
title_ = 'Low-value bandit';
render_bandit_means(title_, data_, xlabels_, ylabel_)

% addpath('../../../export_fig')
% export_fig(['Fig_InitialSamples.tif'],'-nocrop','-r200')

