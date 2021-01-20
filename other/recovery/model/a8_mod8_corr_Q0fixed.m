
addpath('../parameter_mod12/')
sim_fol='../../../../data/sim_model_recov/';

n_sim = 100;
model = 'mod8_normal_Q0fixed_gamma_0_0.5_tau_20_70_sgm0_1_300_Q055_sgm014_newB';
saving_dir = strcat(sim_fol,model,'/n_sim_',num2str(n_sim), '/');

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 40 30]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

load(strcat(saving_dir, 'inp_params.mat'))
load(strcat(saving_dir, 'out_sim.mat'))
load(strcat(saving_dir, 'param_bounds.mat'))

%{'gamma'  ''  'tau'  ''  'xi'  ''  'eta' ''}; 

para_vals_generated = out.org;
para_vals_fitted = out.fitted;

% Figure 
 
subplot(3,4,2)
title_ = '\fontsize{22} \gamma_{SH}';
legend_position = [0.326278659611993 0.826709247052752 0.0846560846560847 0.059132113181947];
min_ = min(min(para_vals_fitted(:,1), para_vals_generated(:,1)));
max_ = max(max(para_vals_fitted(:,1), para_vals_generated(:,1)));
render_corr(para_vals_fitted(:,1),para_vals_generated(:,1), [min_, max_], [0:1:4], title_, 'b', legend_position);
 
subplot(3,4,3)
title_ = '\fontsize{22} \gamma_{LH}';
legend_position = [0.537037037037037 0.844964638051681 0.0846560846560847 0.0630133715761289];
min_ = min(min(para_vals_fitted(:,2), para_vals_generated(:,2)));
max_ = max(max(para_vals_fitted(:,2), para_vals_generated(:,2)));
render_corr(para_vals_fitted(:,2),para_vals_generated(:,2), [min_, max_], [0:1:4], title_, 'c', legend_position);
  
subplot(3,4,4)
title_ = '\fontsize{22} \tau_{SH}';
legend_position = [0.804232804232805 0.7219752519044 0.0846560846560847 0.0630133715761289];
min_ = min(min(para_vals_fitted(:,3), para_vals_generated(:,3)));
max_ = max(max(para_vals_fitted(:,3), para_vals_generated(:,3)));
render_corr(para_vals_fitted(:,3),para_vals_generated(:,3), [min_, max_], [0:1:4], title_, 'd', legend_position);
 
subplot(3,4,5)
title_ = '\fontsize{22} \tau_{LH}';
legend_position = [0.192239858906526 0.414406654116469 0.0846560846560846 0.0695188006254862];
min_ = min(min(para_vals_fitted(:,4), para_vals_generated(:,4)));
max_ = max(max(para_vals_fitted(:,4), para_vals_generated(:,4)));
render_corr(para_vals_fitted(:,4),para_vals_generated(:,4), [min_, max_], [0:1:4], title_, 'e', legend_position);

subplot(3,4,6)
title_ = '\fontsize{22} \epsilon_{SH}';
legend_position = [0.326278659611993 0.541717106035787 0.0846560846560845 0.0766958427953239];
min_ = min(min(para_vals_fitted(:,5), para_vals_generated(:,5)));
max_ = max(max(para_vals_fitted(:,5), para_vals_generated(:,5)));
render_corr(para_vals_fitted(:,5),para_vals_generated(:,5), [min_, max_], [0:1:4], title_, 'f', legend_position);

subplot(3,4,7)
title_ = '\fontsize{22} \epsilon_{LH}';
legend_position = [0.534391534391534 0.533534974299937 0.0846560846560844 0.0846138346628574];
min_ = min(min(para_vals_fitted(:,6), para_vals_generated(:,6)));
max_ = max(max(para_vals_fitted(:,6), para_vals_generated(:,6)));
render_corr(para_vals_fitted(:,6),para_vals_generated(:,6), [min_, max_], [0:1:4], title_, 'g', legend_position);

subplot(3,4,8)
title_ = '\fontsize{22} \eta_{SH}';
legend_position = [0.801587301587302 0.407408848173811 0.0846560846560844 0.0846138346628575];
min_ = min(min(para_vals_fitted(:,7), para_vals_generated(:,7)));
max_ = max(max(para_vals_fitted(:,7), para_vals_generated(:,7)));
render_corr(para_vals_fitted(:,7),para_vals_generated(:,7), [min_, max_], [0:1:6], title_, 'g', legend_position);

subplot(3,4,9)
title_ = '\fontsize{22} \eta_{LH}';
legend_position = [0.191358024691358 0.0985285392935018 0.0846560846560845 0.0846138346628574];
min_ = min(min(para_vals_fitted(:,8), para_vals_generated(:,8)));
max_ = max(max(para_vals_fitted(:,8), para_vals_generated(:,8)));
render_corr(para_vals_fitted(:,8),para_vals_generated(:,8), [min_, max_], [0:1:6], title_, 'h', legend_position);
   

