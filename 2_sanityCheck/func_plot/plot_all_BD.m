function [matBD, RT_BD_SH, RT_BD_LH] = plot_all_BD(part_num, mat_BD, direc)

mat_BD_short = [];
mat_BD_long = [];
RT_BD_SH = [];
RT_BD_LH = [];

% mat_BD_DB: 
% 1. block
% 2. block_trial
% 3. horizon
% 4. gameID
% 5. sizeB
% 6. sizeD
% 7. chosen tree
% 8. size of chosen apple
% 9. RT

for i = 1:size(mat_BD,1)
    if mat_BD(i,3) == 6
        mat_BD_short(end+1,:) = mat_BD(i,[5:7 9]);
        RT_BD_SH(end+1,:) = mat_BD(i,9);
    elseif mat_BD(i,3) == 11
        mat_BD_long(end+1,:) = mat_BD(i,[5:7 9]);
        RT_BD_LH(end+1,:) = mat_BD(i,9);
    end
end

[mat_long, new_mat_long] = aggregate_for_plot(mat_BD_long);
[mat_short, new_mat_short] = aggregate_for_plot(mat_BD_short);

plot_RT(direc,'BD', part_num, mat_long, new_mat_long, mat_short, new_mat_short);

[diff_and_prob_tree_short, diff_and_prob_tree_long, mean_and_prob_tree_short, mean_and_prob_tree_long] = plot_prob('BD', part_num, mat_BD_short, mat_BD_long, direc);

% Fill in with nans so that they will all be between a range of -10 and 10
new_mat_short_ = nan_padding(new_mat_short);
new_mat_long_ = nan_padding(new_mat_long);
diff_and_prob_tree_short_ = nan_padding(diff_and_prob_tree_short);
diff_and_prob_tree_long_ = nan_padding(diff_and_prob_tree_long);
mean_and_prob_tree_short_ = nan_padding(mean_and_prob_tree_short);
mean_and_prob_tree_long_ = nan_padding(mean_and_prob_tree_long);

matBD.apple_difference.shortHor.RT = new_mat_short_;
matBD.apple_difference.longHor.RT = new_mat_long_;
matBD.apple_difference.shortHor.prob_choosing = diff_and_prob_tree_short_;
matBD.apple_difference.longHor.prob_choosing = diff_and_prob_tree_long_;
matBD.apple_mean.shortHor.prob_choosing = mean_and_prob_tree_short_;
matBD.apple_mean.longHor.prob_choosing = mean_and_prob_tree_long_;

end
