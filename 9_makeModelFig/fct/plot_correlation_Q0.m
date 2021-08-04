
close all;

%%% Data

load('../../data/data_for_figs/mod8_Q0.mat');
mod8 = Q0;

load('../../data/data_for_figs/mod12_Q0.mat');
mod12 = Q0;


% Remove ID
load('../usermat_completed.mat')

to_del = [];
to_del(end+1) = find(usermat_completed==4);
to_del(end+1) = find(usermat_completed==34);
to_del(end+1) = find(usermat_completed==39);

mod8(to_del,:) = [];
mod12(to_del,:) = [];

%%% Plot

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

title_ = 'Q_0';
render_corr(mod12,mod8, param_bounds_Q0, [0:1:6], title_, '', []);

% Export
addpath('../../export_fig')
export_fig(['./fig/Fig_corr_Q0.tif'],'-nocrop','-r200')

