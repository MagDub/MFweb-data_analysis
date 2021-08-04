
sim_fol='../../../../data/sim_model_recov/';

n_sim = 100;
model = 'mod8_normal_Q0fixed_gamma_0_0.5_tau_20_70_sgm0_1_300_Q055_sgm014';
saving_dir = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

load(strcat(saving_dir, 'inp_params.mat'))
load(strcat(saving_dir, 'out_sim.mat'))
load(strcat(saving_dir, 'param_bounds.mat'))

%{'gamma'  ''  'tau'  ''  'xi'  ''  'eta' ''}

para_vals_generated = out.org;
para_vals_fitted = out.fitted;

%% Figure 

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 10 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

render_param_recovery_mod8_Q0fixed(out)

% % Export
% addpath('../../export_fig')
% export_fig('./fig/Fig_sim_conf_mat.tif','-nocrop','-r200')