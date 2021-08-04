function [matAB, RT_AB_SH, RT_AB_LH] = plot_all_AB(part_num, mat_AB, direc)

mat_AB_short = [];
mat_AB_long = [];
tmp_short = [];
tmp_long = [];
RT_AB_SH = [];
RT_AB_LH = [];

% mat_AB: 
% 1. block
% 2. block_trial
% 3. horizon
% 4. gameID
% 5. sizeA
% 6. sizeA
% 7. sizeA
% 8. sizeB
% 9. chosen tree
% 10. size of chosen apple
% 11. RT

for i = 1:size(mat_AB,1)
    if mat_AB(i,3) == 6
        tmp_short(end+1,:) = mat_AB(i,[5:9 11]);
        RT_AB_SH(end+1,:) = mat_AB(i,11);
    elseif mat_AB(i,3) == 11
        tmp_long(end+1,:) = mat_AB(i,[5:9 11]);
        RT_AB_LH(end+1,:) = mat_AB(i,11);
    end
end

% tmp: 
% 1. sizeA
% 2. sizeA
% 3. sizeA
% 4. sizeB
% 5. chosen tree
% 6. RT

% mean(A), B, picked, RT (4 columns)
mat_AB_short(:,1) = mean(tmp_short(:,1:3),2);
mat_AB_short(:,2:4) = tmp_short(:,4:6);
mat_AB_long(:,1) = mean(tmp_long(:,1:3),2);
mat_AB_long(:,2:4) = tmp_long(:,4:6);

% Aggregate
[mat_long, new_mat_long] = aggregate_for_plot(mat_AB_long);
[mat_short, new_mat_short] = aggregate_for_plot(mat_AB_short);

% Plot
plot_RT(direc,'AB',part_num, mat_long, new_mat_long, mat_short, new_mat_short);
[diff_and_prob_tree_short, diff_and_prob_tree_long, mean_and_prob_tree_short, mean_and_prob_tree_long] = plot_prob('AB', part_num, mat_AB_short, mat_AB_long, direc);

% Fill in with nans so that they will all be between a range of -10 and 10
new_mat_short_ = nan_padding(new_mat_short);
new_mat_long_ = nan_padding(new_mat_long);
diff_and_prob_tree_short_ = nan_padding(diff_and_prob_tree_short);
diff_and_prob_tree_long_ = nan_padding(diff_and_prob_tree_long);
mean_and_prob_tree_short_ = nan_padding(mean_and_prob_tree_short);
mean_and_prob_tree_long_ = nan_padding(mean_and_prob_tree_long);

matAB.apple_difference.shortHor.RT = new_mat_short_;
matAB.apple_difference.longHor.RT = new_mat_long_;
matAB.apple_difference.shortHor.prob_choosing = diff_and_prob_tree_short_;
matAB.apple_difference.longHor.prob_choosing = diff_and_prob_tree_long_;
matAB.apple_mean.shortHor.prob_choosing = mean_and_prob_tree_short_;
matAB.apple_mean.longHor.prob_choosing = mean_and_prob_tree_long_;

end
