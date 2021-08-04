function [matABD, RT_ABD_SH, RT_ABD_LH] = plot_all_ABD(part_num, mat_ABD, direc)

mat_ABD_short = [];
mat_ABD_long = [];
% mat_ABD_short_AB = [];
% mat_ABD_long_AB = [];
tmp_short = [];
tmp_long = [];
RT_ABD_SH = [];
RT_ABD_LH = [];

% mat_ABD: 
% 1. block
% 2. block_trial
% 3. horizon
% 4. gameID
% 5. sizeA
% 6. sizeA
% 7. sizeA
% 8. sizeB
% 9. sizeD
% 10. chosen tree
% 11. size of chosen apple
% 12. RT

for i = 1:size(mat_ABD,1)
    if mat_ABD(i,3) == 6
        tmp_short(end+1,:) = mat_ABD(i,[5:10 12]);
        RT_ABD_SH(end+1,:) = mat_ABD(i,12);
    elseif mat_ABD(i,3) == 11
        tmp_long(end+1,:) = mat_ABD(i,[5:10 12]);
        RT_ABD_LH(end+1,:) = mat_ABD(i,12);
    end
end

% tmp_short: 
% 1. sizeA
% 2. sizeA
% 3. sizeA
% 4. sizeB
% 5. sizeD
% 6. chosen tree
% 7. RT

% mean(A,A,A,B,D), RT (4 columns)
mat_ABD_short(:,1) = mean(tmp_short(:,1:4),2); % 4: A, A, A, B
mat_ABD_short(:,2:4) = tmp_short(:,5:7);
mat_ABD_long(:,1) = mean(tmp_long(:,1:4),2);
mat_ABD_long(:,2:4) = tmp_long(:,5:7);

%
% % mean(A), B, picked, RT (4 columns)
% mat_ABD_short_AB(:,1) = mean(tmp_short(:,1:3),2); % 3: A, A, A
% mat_ABD_short_AB(:,2:5) = tmp_short(:,4:7);
% mat_ABD_long_AB(:,1) = mean(tmp_long(:,1:3),2);
% mat_ABD_long_AB(:,2:5) = tmp_long(:,4:7);

% Aggregate
[mat_long, new_mat_long] = aggregate_for_plot(mat_ABD_long);
[mat_short, new_mat_short] = aggregate_for_plot(mat_ABD_short);

% %AB
% [mat_long_AB, new_mat_long_AB] = aggregate_for_plot(mat_ABD_long_AB);
% [mat_short_AB, new_mat_short_AB] = aggregate_for_plot(mat_ABD_short_AB);

% Plot
plot_RT(direc,'ABD',part_num, mat_long, new_mat_long, mat_short, new_mat_short);
[diff_and_prob_tree_short, diff_and_prob_tree_long, mean_and_prob_tree_short, mean_and_prob_tree_long] = plot_prob('ABD', part_num, mat_ABD_short, mat_ABD_long, direc);

% %AB
% plot_RT('ABD_AB',part_num, mat_long_AB, new_mat_long_AB, mat_short_AB, new_mat_short_AB);
% [diff_and_prob_tree_short_AB, diff_and_prob_tree_long_AB, mean_and_prob_tree_short_AB, mean_and_prob_tree_long_AB] = plot_prob('ABD_AB', part_num, mat_ABD_short_AB, mat_ABD_long_AB);

% Fill in with nans so that they will all be between a range of -10 and 10
new_mat_short_ = nan_padding(new_mat_short);
new_mat_long_ = nan_padding(new_mat_long);
diff_and_prob_tree_short_ = nan_padding(diff_and_prob_tree_short);
diff_and_prob_tree_long_ = nan_padding(diff_and_prob_tree_long);
mean_and_prob_tree_short_ = nan_padding(mean_and_prob_tree_short);
mean_and_prob_tree_long_ = nan_padding(mean_and_prob_tree_long);

% % AB
% new_mat_short_AB_ = nan_padding(new_mat_short_AB);
% new_mat_long_AB_ = nan_padding(new_mat_long_AB);
% diff_and_prob_tree_short_AB_ = nan_padding(diff_and_prob_tree_short_AB);
% diff_and_prob_tree_long_AB_ = nan_padding(diff_and_prob_tree_long_AB);
% mean_and_prob_tree_short_AB_ = nan_padding(mean_and_prob_tree_short_AB);
% mean_and_prob_tree_long_AB_ = nan_padding(mean_and_prob_tree_long_AB);

matABD.apple_difference.shortHor.RT = new_mat_short_;
matABD.apple_difference.longHor.RT = new_mat_long_;
matABD.apple_difference.shortHor.prob_choosing = diff_and_prob_tree_short_;
matABD.apple_difference.longHor.prob_choosing = diff_and_prob_tree_long_;
matABD.apple_mean.shortHor.prob_choosing = mean_and_prob_tree_short_;
matABD.apple_mean.longHor.prob_choosing = mean_and_prob_tree_long_;

% % AB
% matABD_AB.apple_difference.shortHor.RT = new_mat_short_AB_;
% matABD_AB.apple_difference.longHor.RT = new_mat_long_AB_;
% matABD_AB.apple_difference.shortHor.prob_choosing = diff_and_prob_tree_short_AB_;
% matABD_AB.apple_difference.longHor.prob_choosing = diff_and_prob_tree_long_AB_;
% matABD_AB.apple_mean.shortHor.prob_choosing = mean_and_prob_tree_short_AB_;
% matABD_AB.apple_mean.longHor.prob_choosing = mean_and_prob_tree_long_AB_;

end
