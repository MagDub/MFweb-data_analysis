function [matABD] = plot_all_AB_ABD(part_num, mat_ABD, direc)

mat_ABD_short = [];
mat_ABD_long = [];
tmp_short = [];
tmp_long = [];

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
    elseif mat_ABD(i,3) == 11
        tmp_long(end+1,:) = mat_ABD(i,[5:10 12]);
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

% mean(A,A,A), B, chosen, RT (4 columns)
mat_ABD_short(:,1) = mean(tmp_short(:,1:3),2); % 4: A, A, A
mat_ABD_short(:,2:4) = tmp_short(:,[4,6,7]);
mat_ABD_long(:,1) = mean(tmp_long(:,1:3),2);
mat_ABD_long(:,2:4) = tmp_long(:,[4,6,7]);

% Aggregate
[mat_long, new_mat_long] = aggregate_for_plot(mat_ABD_long);
[mat_short, new_mat_short] = aggregate_for_plot(mat_ABD_short);

% Plot
plot_RT(direc,'AB_ABD',part_num, mat_long, new_mat_long, mat_short, new_mat_short);
[diff_and_prob_tree_short, diff_and_prob_tree_long, mean_and_prob_tree_short, mean_and_prob_tree_long] = plot_prob('AB_ABD', part_num, mat_ABD_short, mat_ABD_long, direc);

% Fill in with nans so that they will all be between a range of -10 and 10
new_mat_short_ = nan_padding(new_mat_short);
new_mat_long_ = nan_padding(new_mat_long);
diff_and_prob_tree_short_ = nan_padding(diff_and_prob_tree_short);
diff_and_prob_tree_long_ = nan_padding(diff_and_prob_tree_long);
mean_and_prob_tree_short_ = nan_padding(mean_and_prob_tree_short);
mean_and_prob_tree_long_ = nan_padding(mean_and_prob_tree_long);

matABD.apple_difference.shortHor.RT = new_mat_short_;
matABD.apple_difference.longHor.RT = new_mat_long_;
matABD.apple_difference.shortHor.prob_choosing = diff_and_prob_tree_short_;
matABD.apple_difference.longHor.prob_choosing = diff_and_prob_tree_long_;
matABD.apple_mean.shortHor.prob_choosing = mean_and_prob_tree_short_;
matABD.apple_mean.longHor.prob_choosing = mean_and_prob_tree_long_;


end
