
n_sim = 1000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand_part_values/';
saving_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

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

% Figure 

subplot(2,4,1)
title_ = '\fontsize{22} \epsilon_{SH}';
legend_position = [0.123456790123457 0.825427395957974 0.0846560846560847 0.0535986493795997];
render_corr(para_vals_fitted(:,4),para_vals_generated(:,4), param_bounds_xi, [0:0.1:0.5], title_, 'a', legend_position);

subplot(2,4,2)
title_ = '\fontsize{22} \epsilon_{LH}';
legend_position = [0.326278659611993 0.826709247052752 0.0846560846560847 0.059132113181947];
render_corr(para_vals_fitted(:,5),para_vals_generated(:,5), param_bounds_xi, [0:0.1:0.5], title_, 'b', legend_position);

subplot(2,4,3)
title_ = '\fontsize{22} \eta_{SH}';
legend_position = [0.615520282186949 0.595940016283521 0.0846560846560847 0.059132113181947];
render_corr(para_vals_fitted(:,6),para_vals_generated(:,6), param_bounds_eta, [0:1:5], title_, 'c', legend_position);

subplot(2,4,4)
title_ = '\fontsize{22} \eta_{LH}';
legend_position = [0.820987654320988 0.608085765271375 0.0846560846560848 0.059132113181947];
render_corr(para_vals_fitted(:,7),para_vals_generated(:,7), param_bounds_eta, [0:1:5], title_, 'd', legend_position);

subplot(2,4,5)
title_ = '\fontsize{18} Q_0';
legend_position = [0.108465608465609 0.370215585339918 0.0846560846560846 0.0652368455144961];
render_corr(para_vals_fitted(:,3),para_vals_generated(:,3), param_bounds_Q0, [1:2:6], title_, 'e', legend_position);

subplot(2,4,6)
title_ = '\fontsize{22} \sigma_{0,SH}';
legend_position = [0.31657848324515 0.358750930358907 0.0846560846560845 0.0719718234927134];
render_corr(para_vals_fitted(:,1),para_vals_generated(:,1), param_bounds_sgm0, [0.5:0.5:2.5], title_, 'f', legend_position);
  
subplot(2,4,7)
title_ = '\fontsize{22} \sigma_{0,LH}';
legend_position = [0.517636684303351 0.361108660117886 0.0846560846560844 0.0794021129626089];
render_corr(para_vals_fitted(:,2),para_vals_generated(:,2), param_bounds_sgm0, [0.5:0.5:2.5], title_, 'g', legend_position);

% % Export
% addpath('../../../../export_fig')
% 
% export_fig('./fig/Fig_sim_corr.tif','-nocrop','-r200')