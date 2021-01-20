
sim_fol='../../../../data/sim_model_recov/';

n_sim = 100;
%model = 'mod8_normal_Q0_1_6_gamma_0_3_tau_25_200_sgm0_1_300';
%model = 'mod8_normal_Q0_1_6_gamma_0_4_tau_5_300_sgm0_1_300_highergamma';
model = 'mod8_normal_Q0_1_6_gamma_0_4_tau_25_200_sgm0_1_300';
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

render_param_recovery_mod8(out)

% % Export
% addpath('../../export_fig')
% export_fig('./fig/Fig_sim_conf_mat.tif','-nocrop','-r200')