function [mat_] = initiate_mat(number_particip)

mat_.RT_all_part_short = nan(number_particip,8);
mat_.diff_all_part_short = nan(number_particip,8);

mat_.RT_all_part_long = nan(number_particip,8);
mat_.diff_all_part_long = nan(number_particip,8);

mat_.diff_ptreeA_all_part_short = nan(number_particip,8);
mat_.diff_ptreeB_all_part_short = nan(number_particip,8);
mat_.diff_ptreeC_all_part_short = nan(number_particip,8);
mat_.diff_ptreeD_all_part_short = nan(number_particip,8);

mat_.mean_ptreeA_all_part_short = nan(number_particip,8);
mat_.mean_ptreeB_all_part_short = nan(number_particip,8);
mat_.mean_ptreeC_all_part_short = nan(number_particip,8);
mat_.mean_ptreeD_all_part_short = nan(number_particip,8);

mat_.diff_ptreeA_all_part_long = nan(number_particip,8);
mat_.diff_ptreeB_all_part_long = nan(number_particip,8);
mat_.diff_ptreeC_all_part_long = nan(number_particip,8);
mat_.diff_ptreeD_all_part_long = nan(number_particip,8);

mat_.mean_ptreeA_all_part_long = nan(number_particip,8);
mat_.mean_ptreeB_all_part_long = nan(number_particip,8);
mat_.mean_ptreeC_all_part_long = nan(number_particip,8);
mat_.mean_ptreeD_all_part_long = nan(number_particip,8);

mat_.diff_p_all_part_short = nan(number_particip,8);
mat_.diff_p_all_part_long = nan(number_particip,8);
mat_.mean_p_all_part_short = nan(number_particip,8);
mat_.mean_p_all_part_long = nan(number_particip,8);

end


