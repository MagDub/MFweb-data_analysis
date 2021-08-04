
n_sim = 1000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand_part_values/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

load(strcat(saving_dir, 'inp_params_thompson.mat'))
load(strcat(saving_dir, 'out_sim_thompson.mat'))

%{'sgm0', 'sgm0', 'Q0','xi', '', 'eta', ''};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

para_vals_generated = out.org;
para_vals_fitted = out.fitted;

%% Figure 

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

render_param_recovery(out)

% % Export
% addpath('../../../../export_fig')
% export_fig('./fig/Fig_sim_conf_mat.tif','-nocrop','-r200')