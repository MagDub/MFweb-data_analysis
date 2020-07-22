function [matAD, RT_AD_SH, RT_AD_LH] = plot_all_AD(part_num, mat_AD,direc)

mat_AD_short = [];
mat_AD_long = [];
tmp_short = [];
tmp_long = [];
RT_AD_SH = [];
RT_AD_LH = [];

% mat_AD: 
% 1. block
% 2. block_trial
% 3. horizon
% 4. gameID
% 5. sizeA
% 6. sizeA
% 7. sizeA
% 8. sizeD
% 9. chosen tree
% 10. size of chosen apple
% 11. RT

for i = 1:size(mat_AD,1)
    if mat_AD(i,3) == 6
        tmp_short(end+1,:) = mat_AD(i,[5:9 11]);
        RT_AD_SH(end+1,:) = mat_AD(i,11);
    elseif mat_AD(i,3) == 11
        tmp_long(end+1,:) = mat_AD(i,[5:9 11]);
        RT_AD_LH(end+1,:) = mat_AD(i,11);
    end
end

% mean(A), B, picked, RT (4 columns)
mat_AD_short(:,1) = mean(tmp_short(:,1:3),2);
mat_AD_short(:,2:4) = tmp_short(:,4:6);
mat_AD_long(:,1) = mean(tmp_long(:,1:3),2);
mat_AD_long(:,2:4) = tmp_long(:,4:6);

% Aggregate
[mat_long, new_mat_long] = aggregate_for_plot(mat_AD_long);
[mat_short, new_mat_short] = aggregate_for_plot(mat_AD_short);

% Plot
plot_RT(direc,'AD',part_num, mat_long, new_mat_long, mat_short, new_mat_short);
[diff_and_prob_tree_short, diff_and_prob_tree_long, mean_and_prob_tree_short, mean_and_prob_tree_long] = plot_prob('AD', part_num, mat_AD_short, mat_AD_long, direc);

% Fill in with nans so that they will all be between a range of -10 and 10
new_mat_short_ = nan_padding(new_mat_short);
new_mat_long_ = nan_padding(new_mat_long);
diff_and_prob_tree_short_ = nan_padding(diff_and_prob_tree_short);
diff_and_prob_tree_long_ = nan_padding(diff_and_prob_tree_long);
mean_and_prob_tree_short_ = nan_padding(mean_and_prob_tree_short);
mean_and_prob_tree_long_ = nan_padding(mean_and_prob_tree_long);

matAD.apple_difference.shortHor.RT = new_mat_short_;
matAD.apple_difference.longHor.RT = new_mat_long_;
matAD.apple_difference.shortHor.prob_choosing = diff_and_prob_tree_short_;
matAD.apple_difference.longHor.prob_choosing = diff_and_prob_tree_long_;
matAD.apple_mean.shortHor.prob_choosing = mean_and_prob_tree_short_;
matAD.apple_mean.longHor.prob_choosing = mean_and_prob_tree_long_;

end
