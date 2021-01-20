
n_sim = 20000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

load(strcat(saving_dir, 'inp_params_thompson.mat'))
load(strcat(saving_dir, 'out_sim_thompson.mat'))

load('../../../../data/data_for_figs/model_parameters.mat')
load('../../../../data/data_for_figs/model_parameters_desc.mat')

model_parameters([4,32,36],:)=nan;
param_mean = nanmean(model_parameters(:,2:end));
param_std = nanstd(model_parameters(:,2:end));

%{'sgm0', 'sgm0', 'Q0','xi', '', 'eta', ''};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

para_vals_generated = out.org;
para_vals_fitted = out.fitted;

max_freq = 1600;

% Figure 

subplot(2,4,1)
title_ = '\fontsize{22} \epsilon_{SH}';
legend_position = [0.182539682539683 0.851743185431658 0.109347442680776 0.0535986493795997];
render_sim_points(para_vals_generated(:,4), param_bounds_xi, [0:0.1:0.5], title_, 'a', legend_position, param_mean(4), param_std(4), max_freq);

subplot(2,4,2)
title_ = '\fontsize{22} \epsilon_{LH}';
legend_position = [0.399911816578483 0.782894736842106 0.0961199294532628 0.069838056680162];
render_sim_points(para_vals_generated(:,5), param_bounds_xi, [0:0.1:0.5], title_, 'b', legend_position, param_mean(5), param_std(5), max_freq);
 
subplot(2,4,3)
title_ = '\fontsize{22} \eta_{SH}';
legend_position = [0.608906525573192 0.801113360323887 0.0961199294532628 0.069838056680162];
render_sim_points(para_vals_generated(:,6), param_bounds_eta, [0:1:5], title_, 'c', legend_position, param_mean(6), param_std(6), max_freq);

subplot(2,4,4)
title_ = '\fontsize{22} \eta_{LH}';
legend_position = [0.74647266313933 0.811234817813766 0.0961199294532628 0.069838056680162];
render_sim_points(para_vals_generated(:,7), param_bounds_eta, [0:1:5], title_, 'd', legend_position, param_mean(7), param_std(7), max_freq);

subplot(2,4,5)
title_ = '\fontsize{18} Q_0';
legend_position = [0.202380952380953 0.321356275303644 0.0961199294532628 0.069838056680162];
render_sim_points(para_vals_generated(:,3), param_bounds_Q0, [0:2:6], title_, 'e', legend_position, param_mean(3), param_std(3), max_freq);
 
subplot(2,4,6)
title_ = '\fontsize{22} \sigma_{0,SH}';
legend_position = [0.400793650793651 0.284185583194809 0.0961199294532628 0.0794021129626089];
render_sim_points(para_vals_generated(:,1), param_bounds_sgm0, [0.5:0.5:2.5], title_, 'f', legend_position, param_mean(1), param_std(1), max_freq);
   
subplot(2,4,7)
title_ = '\fontsize{22} \sigma_{0,LH}';
legend_position = [0.608024691358024 0.300329806108683 0.0961199294532628 0.0875994970943763];
render_sim_points(para_vals_generated(:,2), param_bounds_sgm0, [0.5:0.5:2.5], title_, 'f', legend_position, param_mean(2), param_std(2), max_freq);

% Export
addpath('../../../../export_fig')
export_fig('./fig/Fig_sim_dist.tif','-nocrop','-r200')
